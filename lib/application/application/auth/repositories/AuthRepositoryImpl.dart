
import 'package:acuro/application/application/auth/repositories/AuthRepository.dart';
import 'package:acuro/core/constants/Constants.dart';
import 'package:acuro/core/persistence/PreferenceHelper.dart';
import 'package:acuro/core/utils/ToastUtils.dart';
import 'package:acuro/models/Auth/OtpLimitationModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../../../../models/Auth/UserModel.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  AuthRepositoryImpl();

  CollectionReference userCollection() {
    return fireStore.collection('user');
  }

  CollectionReference otpValidationCollection() {
    return fireStore.collection('otpValidations');
  }

  @override
  Future<String> sendOtp({required String phoneNumber}) async {
    String? verificationId;
    String? errorMessage;
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 4),
      codeSent: (String verId, forceCodeResent) {
        verificationId = verId;
      },
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
      verificationFailed: (FirebaseAuthException error) {
        errorMessage = error.message.toString();
        ToastUtils.showToaster(error.message.toString());
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );

    do {
      await Future.delayed(const Duration(seconds: 1));
    } while (verificationId == null && errorMessage == null);
    if (verificationId != null) {
      return verificationId!;
    } else {
      throw UnimplementedError(errorMessage);
    }
  }

  @override
  Future<UserCredential?> verifyOtp({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      return userCredential;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> userExistsOnDatabase({
    required String mobileNumber,
  }) async {
    try {
      QuerySnapshot querySnapshot = await userCollection()
          .where('phoneNumber', isEqualTo: mobileNumber)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<UserCredential?> signInWithEmail(
      {required String email, required String password}) async {
    UserCredential? credential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    String? accessToken = await credential.user!.getIdToken();
    await PreferenceHelper.setAccessToken(accessToken!);
    return credential;
  }

  @override
  Future<dynamic> addUserToDatabase(
      {required UserModel? userModel, required String authId}) async {
    try {
      await userCollection().doc(authId).set(userModel?.toJson());
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<UserModel?> getUserFromDatabase({required String mobileNumber}) async {
    try {
      QuerySnapshot querySnapshot = await userCollection()
          .where('phoneNumber', isEqualTo: mobileNumber)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return null;
      }
      var userDoc = querySnapshot.docs.first;
      UserModel user = UserModel.fromJson(userDoc.data() as Json);
      return user;
    } catch (e) {
      throw UnimplementedError(e.toString());
    }
  }

  @override
  Future<void> setOtpValidation({
    required String emailOrPhoneName,
    required String otpFrom,
  }) async {
    final docId = '${emailOrPhoneName.replaceAll(' ', '')}-$otpFrom';
    final docRef = otpValidationCollection().doc(docId);
    final docSnapshot = await docRef.get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      final limit = data['limit'] ?? 0;
      await docRef.update({
        'limit': limit + 1,
        'time': DateTime.now().toIso8601String(),
      });
    } else {
      OTPLimitationModel otpLimitationModel = OTPLimitationModel(
          otpFrom: otpFrom,
          emailOrPhoneName: emailOrPhoneName,
          limit: 1,
          time: DateTime.now().toIso8601String()
      );
      await docRef.set(otpLimitationModel.toJson());
    }
  }

  @override
  Future<int> getOtpValidation({
    required String emailOrPhoneName,
    required String otpFrom,
  }) async {
    final docId = '${emailOrPhoneName.replaceAll(' ', '')}-$otpFrom';
    final docRef = otpValidationCollection().doc(docId);
    final docSnapshot = await docRef.get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data();
      OTPLimitationModel model = OTPLimitationModel.fromJson(data as Json);
      DateTime elementTime = DateTime.parse(model.time);
      final difference = DateTime.now().difference(elementTime);

      if (difference.inHours >= 8) {
        await docRef.delete();
        return 0;
      }
      return model.limit;
    }
    return 0;
  }

  @override
  Future<List<OTPLimitationModel>> getAllOTPLimitationList() async {
    final docRef = otpValidationCollection();
    final docSnapshot = await docRef.get();
    return docSnapshot.docs
        .map((e) => OTPLimitationModel.fromJson(e.data() as Json))
        .toList();
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    final docRef = userCollection();
    final docSnapshot = await docRef.get();
    return docSnapshot.docs
        .map((e) => UserModel.fromJson(e.data() as Json))
        .toList();
  }
}
