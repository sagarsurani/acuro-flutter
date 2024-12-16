import 'package:acuro/models/Auth/OtpLimitationModel.dart';
import 'package:acuro/models/Auth/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<String> sendOtp({
    required String phoneNumber,
  });

  Future<UserCredential?> verifyOtp({
    required String verificationId,
    required String smsCode,
  });

  Future<UserCredential?> signInWithEmail(
      {required String email, required String password});

  Future<dynamic> addUserToDatabase({
    required UserModel? userModel,
    required String authId,
  });

  Future<UserModel?> getUserFromDatabase({
    required String authValue,
    required bool isMobile,
  });

  Future<void> setOtpValidation({
    required String authValue,
    required String otpFrom,
    required bool isMobile,
  });

  Future<int> getOtpValidation({
    required String authValue,
    required String otpFrom,
    required bool isMobile,
  });

  Future<bool> userExistsOnDatabase({
    required String authValue,
    required bool isMobile,
  });

  Future<List<UserModel>> getAllUsers();

  Future<List<OTPLimitationModel>> getAllOTPLimitationList();

  Future<void> deleteAnyCollection({
    required String collectionName,
  });

  Future<bool> resetPassword({
    required String authValue,
    required String password,
    required bool isPhone,
  });
  
}
