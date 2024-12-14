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
    required String mobileNumber,
  });

  Future<void> setOtpValidation({
    required String emailOrPhoneName,
    required String otpFrom,
  });

  Future<int> getOtpValidation({
    required String emailOrPhoneName,
    required String otpFrom,
  });

  Future<bool> userExistsOnDatabase({
    required String mobileNumber,
  });

  Future<List<UserModel>> getAllUsers();

  Future<List<OTPLimitationModel>> getAllOTPLimitationList();
}
