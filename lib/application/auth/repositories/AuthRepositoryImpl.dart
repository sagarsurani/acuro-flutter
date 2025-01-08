
import 'dart:async';
import 'package:acuro/application/auth/repositories/AuthRepository.dart';
import 'package:acuro/core/constants/Constants.dart';
import 'package:acuro/core/constants/EnvVariable.dart';
import 'package:acuro/core/persistence/PreferenceHelper.dart';
import 'package:acuro/core/utils/AppUtils.dart';
import 'package:acuro/core/utils/ToastUtils.dart';
import 'package:acuro/models/Auth/OtpLimitationModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../../../../models/Auth/UserModel.dart';
import 'package:dio/dio.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  AuthRepositoryImpl();

  CollectionReference userCollection() {
    return fireStore.collection(EnvVariable.userCollection);
  }

  CollectionReference otpValidationCollection() {
    return fireStore.collection(EnvVariable.otpCollection);
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
  Future<String> sendEmailOtp({required String email}) async {
    try {
      String clientToken = await AppUtils.generateServiceAccountToken(
        cloudUrl: senEmailOtpFunctionUrl,
      );

      Dio dio = Dio();
      dio.options.headers[AUTHORIZATION] = "$BEARER $clientToken";
      dio.options.headers[CONTENT_TYPE] = APPLICATION_JSON;

      try {
        Response response =
            await dio.post(senEmailOtpFunctionUrl, data: {"email": email});
        if (response.statusCode == 200 && response.data != null) {
          var data = response.data;
          if (data['status'] == true && data['data'] != null) {
            return data['data']['validationId'] ?? "";
          }
        }
      } catch (err) {
        print(err.toString());
      }
      return "";
    } catch (err) {
      return "";
    }
  }

  @override
  Future<bool> verifyEmailOtp(
      {required String verificationId, required String code}) async {
    String clientToken = await AppUtils.generateServiceAccountToken(
      cloudUrl: verifyEmailOtpFunctionUrl,
    );

    Dio dio = Dio();
    dio.options.headers[AUTHORIZATION] = "$BEARER $clientToken";
    dio.options.headers[CONTENT_TYPE] = APPLICATION_JSON;

    try {
      Response response = await dio.post(verifyEmailOtpFunctionUrl,
          data: {"validationId": verificationId, "otp": code});

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['status'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }

  @override
  Future<bool> userExistsOnDatabase({
    required String authValue,
    required bool isMobile,
  }) async {
    try {
      QuerySnapshot existingDocs;
      String phone = isMobile ? authValue.replaceAll(" ", "") : "";
      String email = !isMobile ? authValue : "";

      if (isMobile) {
        existingDocs = await userCollection()
            .where(PHONENUMBER, isEqualTo: phone)
            .limit(1)
            .get();
      } else {
        existingDocs = await userCollection()
            .where(EMAIL, isEqualTo: email)
            .limit(1)
            .get();
      }
      if (existingDocs.docs.isEmpty) {
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
    try {
      UserCredential? credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      String? accessToken = await credential.user!.getIdToken();
      await PreferenceHelper.setAccessToken(accessToken!);
      return credential;
    } catch (err) {
      return null;
    }
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
  Future<UserModel?> getUserFromDatabase({
    required String authValue,
    required bool isMobile,
  }) async {
    try {
      QuerySnapshot existingDocs;
      String phone = isMobile ? authValue.replaceAll(" ", "") : "";
      String email = !isMobile ? authValue : "";

      if (isMobile) {
        existingDocs = await userCollection()
            .where(PHONENUMBER, isEqualTo: phone)
            .limit(1)
            .get();
      } else {
        existingDocs = await userCollection()
            .where(EMAIL, isEqualTo: email)
            .limit(1)
            .get();
      }

      if (existingDocs.docs.isEmpty) {
        return null;
      }
      var userDoc = existingDocs.docs.first;
      UserModel user = UserModel.fromJson(userDoc.data() as Json);
      return user;
    } catch (e) {
      throw UnimplementedError(e.toString());
    }
  }

  @override
  Future<void> setOtpValidation({
    required String authValue,
    required String otpFrom,
    required bool isMobile,
  }) async {
    try {
      QuerySnapshot existingDocs;
      String phone = isMobile ? authValue.replaceAll(" ", "") : "";
      String email = !isMobile ? authValue : "";

      if (isMobile) {
        existingDocs = await otpValidationCollection()
            .where(PHONENUMBER, isEqualTo: phone)
            .where(OTPFROM, isEqualTo: otpFrom)
            .limit(1)
            .get();
      } else {
        existingDocs = await otpValidationCollection()
            .where(EMAIL, isEqualTo: email)
            .where(OTPFROM, isEqualTo: otpFrom)
            .limit(1)
            .get();
      }

      if (existingDocs.docs.isNotEmpty) {
        var existingDoc = existingDocs.docs.first;
        var docData = existingDoc.data() as Map<String, dynamic>;
        int currentLimit = docData['limit'] ?? 0;
        await otpValidationCollection().doc(existingDoc.id).update({
          'limit': currentLimit + 1,
          'time': DateTime.now().toUtc().toIso8601String(),
        });
      } else {
        OTPLimitationModel otpLimitationModel = OTPLimitationModel(
          otpFrom: otpFrom,
          email: email,
          phoneNumber: phone,
          limit: 1,
          time: DateTime.now().toIso8601String(),
        );
        await otpValidationCollection().add(otpLimitationModel.toJson());
      }
    } catch (err) {
      throw UnimplementedError(err.toString());
    }
  }

  @override
  Future<int> getOtpValidation({
    required String authValue,
    required String otpFrom,
    required bool isMobile,
  }) async {
    try {
      QuerySnapshot existingDocs;
      String phone = isMobile ? authValue.replaceAll(" ", "") : "";
      String email = !isMobile ? authValue : "";

      if (isMobile) {
        existingDocs = await otpValidationCollection()
            .where(PHONENUMBER, isEqualTo: phone)
            .where(OTPFROM, isEqualTo: otpFrom)
            .limit(1)
            .get();
      } else {
        existingDocs = await otpValidationCollection()
            .where(EMAIL, isEqualTo: email)
            .where(OTPFROM, isEqualTo: otpFrom)
            .limit(1)
            .get();
      }

      if (existingDocs.docs.isNotEmpty) {
        var existingDoc = existingDocs.docs.first;
        var docData = existingDoc.data() as Map<String, dynamic>;
        OTPLimitationModel model = OTPLimitationModel.fromJson(docData);
        DateTime elementTime = DateTime.parse(model.time);
        final difference = DateTime.now().toUtc().difference(elementTime);
        if (difference.inHours >= 8) {
          await otpValidationCollection().doc(existingDoc.id).delete();
          return 0;
        }
        return model.limit;
      }
      return 0;
    } catch (err) {
      return 0;
    }
  }

  @override
  Future<bool> resetPassword({
    required String authValue,
    required String password,
    required bool isPhone,
  }) async {
    QuerySnapshot existingDocs;
    String phone = isPhone ? authValue.replaceAll(" ", "") : "";
    String email = !isPhone ? authValue : "";

    try {
      if (isPhone) {
        existingDocs = await userCollection()
            .where(PHONENUMBER, isEqualTo: phone)
            .limit(1)
            .get();
      } else {
        existingDocs = await userCollection()
            .where(EMAIL, isEqualTo: email)
            .limit(1)
            .get();
      }

      if (existingDocs.docs.isNotEmpty) {
        var existingDoc = existingDocs.docs.first;
        String uid = existingDoc.id;
        String clientToken = await AppUtils.generateServiceAccountToken(
            cloudUrl: updatePasswordUrl);
        Dio dio = Dio();
        try {
          dio.options.headers[AUTHORIZATION] = "$BEARER $clientToken";
          dio.options.headers[CONTENT_TYPE] = APPLICATION_JSON;
          await dio.post(updatePasswordUrl,
              data: {"uid": uid, "password": password});
        } catch (err) {
          throw UnimplementedError();
        }
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }
}
