import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:acuro/application/application/auth/repositories/AuthRepository.dart';
import 'package:acuro/core/constants/Constants.dart';
import 'package:acuro/core/constants/EnvVariable.dart';
import 'package:acuro/core/persistence/PreferenceHelper.dart';
import 'package:acuro/core/utils/ToastUtils.dart';
import 'package:acuro/models/Auth/OtpLimitationModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:injectable/injectable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asn1/asn1_parser.dart';
import 'package:pointycastle/asn1/primitives/asn1_integer.dart';
import 'package:pointycastle/asn1/primitives/asn1_sequence.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/signers/rsa_signer.dart';
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
    // static return way
    return "12345678901234567890";
  }

  @override
  Future<bool> verifyEmailOtp(
      {required String verificationId, required String code}) async {
    // static return way
    if (verificationId == "12345678901234567890" && code == "123456") {
      return true;
    } else {
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
        existingDocs = await otpValidationCollection()
            .where(PHONENUMBER, isEqualTo: phone)
            .limit(1)
            .get();
      } else {
        existingDocs = await otpValidationCollection()
            .where(EMAIL, isEqualTo: email)
            .limit(1)
            .get();
      }

      if (existingDocs.docs.isNotEmpty) {
        var existingDoc = existingDocs.docs.first;
        String uid = existingDoc.id;

        String clientToken = await generateTokenAndCallResetCloudFun();

        // print(data.toString());
        print("________________ 0");
        print(uid);
        Dio dio = Dio();

        // dio.options.headers = {
        //   AUTHORIZATION : '$BEARER $clientToken',
        //   CONTENT_TYPE : APPLICATION_JSON,
        // };
        dio.options.headers[AUTHORIZATION] = "$BEARER $clientToken";
        // dio.options.headers[AUTHORIZATION] = "$BEARER ${clientToken.replaceAll('"', '')}";
        dio.options.headers[CONTENT_TYPE] = APPLICATION_JSON;
        Response apiResponse = await dio
            .post(updatePasswordUrl, data: {"uid": uid, "password": password});
        if (apiResponse.statusCode != 200) {
          print("________________ 1");
          throw UnimplementedError();
        }
        print("________________ 2");
        print("true");
      }
      return true;
    } catch (err) {
      print("Error in resetPassword: $err");
      return false;
    }
  }

  Future<String> generateTokenAndCallResetCloudFun() async {
    try {
      // final clientEmail = serviceAccount['client_email'];
      // final privateKey = serviceAccount['private_key'];
      // final clientId = serviceAccount['client_id'];
      //

      final String response = await rootBundle.loadString("assets/cloud/acuro_service.json");
      Map<String, dynamic> serviceAccount = await json.decode(response);
      List<String> scopes = [
        'https://www.googleapis.com/auth/cloud-platform',
        'https://www.googleapis.com/auth/firebase.database',
        // 'https://www.googleapis.com/auth/userinfo.email',
      ];

      final accountCredentials = ServiceAccountCredentials.fromJson(serviceAccount);
      // final client = http.Client();

      // 1
      // AccessCredentials client1 = await obtainAccessCredentialsViaServiceAccount(accountCredentials, scopes,client);

      // 2
      // final authClient = await clientViaServiceAccount(
      //   ServiceAccountCredentials(clientEmail, ClientId(clientId), privateKey),
      //   scopes,
      // );

      // 3
      AuthClient client1 = await clientViaServiceAccount(accountCredentials, scopes);
      // final client = await clientViaServiceAccount(accountCredentials, scopes);

      // 4
      // final response1 = await client.get(Uri.parse('https://www.googleapis.com/auth/cloud-platform'));


      // Make a request to an API endpoint (e.g., Google Cloud Storage or any other Google service)

      // 4
      // if (response1.statusCode == 200) {
      //   final responseData = jsonDecode(response1.body);
      //   log(responseData['access_token']);
      //   return responseData['access_token'];
      // } else {
      //   throw Exception('Failed to obtain access token: ${response1.body}');
      // }


      log("_________________");
      log(client1.credentials.accessToken.data);
      log(client1.credentials.accessToken.type);
      log(client1.credentials.accessToken.expiry.toString());
      log(client1.credentials.idToken ?? "null token");
      final token = client1.credentials.accessToken.data ?? "";


      return token;
    } catch (err) {
      print(" Error ________________ ${err.toString()}");
      return "";
    }
  }
  //
  // void decodeToken(String jwtToken) {
  //   Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken);
  //   log(decodedToken.toString());
  // }

  // Future<String> generateJwt() async {
  //   final String response =
  //       await rootBundle.loadString("assets/cloud/acuro_service.json");
  //   Map<String, dynamic> serviceAccount = await json.decode(response);
  //   final privateKey = serviceAccount['private_key'];
  //   String cleanedPrivateKey = privateKey.replaceAll(RegExp(r'(-+BEGIN PRIVATE KEY-+|-+END PRIVATE KEY-+|\n)'), '');
  //   final clientEmail = serviceAccount['client_email'];
  //   // final clientId = serviceAccount['client_id'];
  //
  //   Map<String, dynamic> payload = {
  //     "iss": clientEmail, // From JSON `client_email`
  //     "scope":
  //         'https://www.googleapis.com/auth/cloud-platform', // Define scopes
  //     "aud": 'https://oauth2.googleapis.com/token',
  //     "exp":
  //         (DateTime.now().microsecondsSinceEpoch) + 3600, // 1-hour expiration
  //     "iat": (DateTime.now().microsecondsSinceEpoch),
  //   };
  //
  //   // Create the header
  //   final header = json.encode({
  //     'alg': 'RS256',
  //     'typ': 'JWT',
  //   });
  //
  //   // Base64Url encode the header
  //   final encodedHeader = base64Url.encode(utf8.encode(header));
  //
  //   // Base64Url encode the payload
  //   final encodedPayload = base64Url.encode(utf8.encode(json.encode(payload)));
  //
  //   // Concatenate header and payload
  //   final unsignedJwt = '$encodedHeader.$encodedPayload';
  //
  //   // Sign the JWT with the private key
  //   final signer = RSASigner(SHA256Digest(), privateKey);
  //   final signature = signer.generateSignature(utf8.encode(unsignedJwt));
  //
  //   // Base64Url encode the signature
  //   final encodedSignature = base64Url.encode(signature.bytes);
  //
  //   // Concatenate to form the final JWT
  //   return '$unsignedJwt.$encodedSignature';
  // }

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

  @override
  Future<void> deleteAnyCollection({
    required String collectionName,
  }) async {
    await fireStore.collection(collectionName).get().then((value) {
      value.docs.forEach((element) {
        element.reference.delete();
      });
    });
    print("___________delete 1");
  }
}
