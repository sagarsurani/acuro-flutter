import 'package:acuro/core/constants/Constants.dart';
import 'package:acuro/core/persistence/PreferenceHelper.dart';
import 'package:acuro/core/utils/ToastUtils.dart';
import 'package:acuro/models/Auth/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../repositories/AuthRepository.dart';
import 'AuthEvent.dart';
import 'AuthState.dart';

@Singleton()
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SendOtpEvent>(_sendOtp);
    on<VerifyOtpEvent>(_verifyOtp);
    on<ResendOtpEvent>(_resendOtpEvent);
    on<EmailAuthSignUpEvent>(_emailLoginEvent);
    on<LoginAuthEvent>(_loginAuthEvent);
  }

  Future<void> _sendOtp(SendOtpEvent event, Emitter<AuthState> emit) async {
    try {
      String varId = "";
      emit(AuthLoading());
      if (event.isFromForgot) {
        bool isUserExists = await authRepository.userExistsOnDatabase(
            mobileNumber: event.phoneNumber);
        if (isUserExists) {
          varId = await authRepository.sendOtp(phoneNumber: event.phoneNumber);
          emit(AuthOtpSent(verificationId: varId));
        } else {
          emit(AuthInitial());
          emit(const AuthError(errorMessage: NUMBER_NOT_REGISTER));
        }
      } else {
        varId = await authRepository.sendOtp(phoneNumber: event.phoneNumber);
        emit(AuthOtpSent(verificationId: varId));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(errorMessage: ToastUtils.getAuthMessage(e.toString())));
    } catch (e) {
      emit(AuthError(errorMessage: ToastUtils.getAuthMessage(e.toString())));
    }
  }

  Future<void> _verifyOtp(VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthVerifyLoading());
    try {
      UserCredential? userCredential = await authRepository.verifyOtp(
        verificationId: event.verificationId,
        smsCode: event.smsCode,
      );
      if (userCredential != null) {
        emit(AuthVerified(userCredential: userCredential));
      } else {
        emit(const AuthError(errorMessage: ""));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(errorMessage: ToastUtils.getAuthMessage(e.toString())));
    }
  }

  Future<void> _resendOtpEvent(
      ResendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthVerifyLoading());
    try {
      String verificationId =
          await authRepository.sendOtp(phoneNumber: event.phoneNumber);
      emit(ResendOtpSend(verificationId: verificationId));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(errorMessage: ToastUtils.getAuthMessage(e.toString())));
    } catch (e) {
      emit(AuthError(errorMessage: ToastUtils.getAuthMessage(e.toString())));
    }
  }

  Future<void> _emailLoginEvent(
      EmailAuthSignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential? credential;
      User? currentUser = auth.currentUser;

      AuthCredential emailCredential = EmailAuthProvider.credential(
          email: event.email, password: event.password);
      credential = await currentUser?.linkWithCredential(emailCredential);

      String? accessToken = await credential?.user?.getIdToken();
      await PreferenceHelper.setAccessToken(accessToken!);

      if (credential != null && credential.user!.email != null) {
        event.userData.phoneNumber = credential.user?.phoneNumber ?? "0";
        event.userData.createdAt = DateTime.now();
        await authRepository.addUserToDatabase(
            userModel: event.userData, authId: credential.user?.uid ?? "");
        emit(EmailAuthDone(userCredential: credential));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(errorMessage: ToastUtils.getAuthMessage(e.toString())));
    } catch (err) {
      emit(AuthError(errorMessage: ToastUtils.getAuthMessage(err.toString())));
    }
  }

  Future<void> _loginAuthEvent(
      LoginAuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      String email = "";
      UserCredential? userCredential;

      if (event.loginType == LoginType.signInWithPhone) {
        UserModel? userModel = await authRepository.getUserFromDatabase(
            mobileNumber: event.emailOrPhone);
        if (userModel != null && userModel.email != null) {
          email = userModel.email ?? "";
        }
      } else {
        email = event.emailOrPhone;
      }

      if (email.isNotEmpty) {
        userCredential = await authRepository.signInWithEmail(
            email: email, password: event.password);
      } else {
        emit(const AuthError(errorMessage: SOMETHING_WANT_WRONG));
      }
      if (userCredential != null && userCredential.user!.email != null) {
        String? accessToken = await userCredential.user?.getIdToken();
        await PreferenceHelper.setAccessToken(accessToken ?? "");
        emit(LoginAuthDone(userCredential: userCredential));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(errorMessage: ToastUtils.getAuthMessage(e.toString())));
    }
  }
}
