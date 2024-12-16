import 'package:acuro/core/constants/Constants.dart';
import 'package:acuro/core/persistence/PreferenceHelper.dart';
import 'package:acuro/core/utils/ToastUtils.dart';
import 'package:acuro/models/Auth/OtpLimitationModel.dart';
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
    on<GetAllUsers>(_getAllUsers);
    on<GetAllOtpCollection>(_getAllOtpCollection);
    on<DeleteAnyCollection>(_deleteAnyCollection);
    on<ResetPassword>(_resetPassword);
  }

  Future<void> _sendOtp(SendOtpEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      String varId = "";
      if (event.isFromForgot) {
        bool isUserExists = await authRepository.userExistsOnDatabase(
            authValue: event.phoneNumber, isMobile: true);
        if (!isUserExists) {
          emit(const AuthError(errorMessage: NUMBER_NOT_REGISTER));
          return;
        }
      }
      int otpAttempt = await authRepository.getOtpValidation(
          authValue: event.phoneNumber,
          otpFrom: event.isFromForgot ? FORGOTPHONE : PHONEAUTH,
          isMobile: true);

      if (otpAttempt > 5) {
        emit(AuthInitial());
        emit(const AuthError(errorMessage: SO_MANY_ATTEMPT));
        return;
      }

      varId = await authRepository.sendOtp(phoneNumber: event.phoneNumber);

      await authRepository.setOtpValidation(
          authValue: event.phoneNumber,
          otpFrom: event.isFromForgot ? FORGOTPHONE : PHONEAUTH,
          isMobile: true);

      emit(AuthOtpSent(verificationId: varId));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(errorMessage: ToastUtils.getAuthMessage(e.toString())));
    } catch (e) {
      emit(AuthError(errorMessage: ToastUtils.getAuthMessage(e.toString())));
    }
  }

  Future<void> _verifyOtp(VerifyOtpEvent event, Emitter<AuthState> emit) async {
    print("_____________ 2");
    emit(AuthVerifyLoading());
    try {
      print("_____________ 3");
      UserCredential? userCredential = await authRepository.verifyOtp(
        verificationId: event.verificationId,
        smsCode: event.smsCode,
      );
      print("_____________ 4");
      if (userCredential != null) {
        emit(AuthVerified(userCredential: userCredential));
      } else {
        print("_____________ 5");
        emit(const AuthVerifyError(errorMessage: ""));
      }
    } on FirebaseAuthException catch (e) {
      print("_____________ 6");
      emit(AuthVerifyError(errorMessage: ToastUtils.getAuthMessage(e.toString())));
    }
  }

  Future<void> _resendOtpEvent(
      ResendOtpEvent event, Emitter<AuthState> emit) async {
    String varId = "";
    try {
      int otpAttempt = await authRepository.getOtpValidation(
          authValue: event.phoneNumber,
          otpFrom: event.isFromForgot ? FORGOTPHONE : PHONEAUTH,
          isMobile: true);

      if (otpAttempt > 5) {
        emit(AuthInitial());
        emit(const AuthVerifyError(errorMessage: SO_MANY_ATTEMPT));
        return;
      }
      varId = await authRepository.sendOtp(phoneNumber: event.phoneNumber);

      await authRepository.setOtpValidation(
          authValue: event.phoneNumber,
          otpFrom: event.isFromForgot ? FORGOTPHONE : PHONEAUTH,
          isMobile: true);
      emit(ResendOtpSend(verificationId: varId));
    } on FirebaseAuthException catch (e) {
      emit(AuthVerifyError(
          errorMessage: ToastUtils.getAuthMessage(e.toString())));
    } catch (e) {
      emit(AuthVerifyError(
          errorMessage: ToastUtils.getAuthMessage(e.toString())));
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

      if (credential != null && credential.user!.email != null) {
        // set accessToken to preference
        String? accessToken = await credential.user?.getIdToken();
        await PreferenceHelper.setAccessToken(accessToken!);
        await PreferenceHelper.setIsLogin(false);
        // set user data to database
        event.userData.phoneNumber = credential.user?.phoneNumber ?? "0";
        event.userData.createdAt = DateTime.now();
        await authRepository.addUserToDatabase(
            userModel: event.userData, authId: credential.user?.uid ?? "");
        // emit state
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
    emit(LoginAuthLoading());

    try {
      String email = event.loginType == LoginType.signInWithPhone
          ? await getEmailFromUserData(event.emailOrPhone, true)
          : event.emailOrPhone;

      if (email.isEmpty) {
        emit(const LoginAuthError(errorMessage: SOMETHING_WANT_WRONG));
        return;
      }

      UserCredential? userCredential = await authRepository.signInWithEmail(
        email: email,
        password: event.password,
      );

      if (userCredential != null && userCredential.user?.email != null) {
        String? accessToken = await userCredential.user?.getIdToken();
        await PreferenceHelper.setAccessToken(accessToken ?? "");
        await PreferenceHelper.setIsLogin(true);
        emit(LoginAuthDone(userCredential: userCredential));
      } else {
        emit(const LoginAuthError(errorMessage: SOMETHING_WANT_WRONG));
      }
    } on FirebaseAuthException catch (e) {
      emit(LoginAuthError(
        errorMessage: ToastUtils.getAuthMessage(e.toString()),
      ));
    } catch (e) {
      emit(LoginAuthError(
        errorMessage: ToastUtils.getAuthMessage(e.toString()),
      ));
    }
  }

  Future<void> _resetPassword(
      ResetPassword event, Emitter<AuthState> emit) async {
    emit(ResetAuthLoading());
    try {
      bool isResetPasswordDone = await authRepository.resetPassword(
          authValue: event.emailOrPhone,
          password: event.password,
          isPhone: event.isPhone);
      if (!isResetPasswordDone) {
        emit(const ResetPasswordError(errorMessage: SOMETHING_WANT_WRONG));
        return;
      }
      emit(ResetPasswordDone());
    } catch (err) {
      emit(ResetPasswordError(errorMessage: err.toString()));
    }
  }

  Future<String> getEmailFromUserData(String emailOrPhone, bool isPhone) async {
    UserModel? userModel = await authRepository.getUserFromDatabase(
        authValue: emailOrPhone, isMobile: isPhone);
    if (userModel != null) {
      return userModel.email ?? "";
    } else {
      return "";
    }
  }

  Future<String> isUserExistsOnDatabase(
      String emailOrPhone, bool isPhone) async {
    UserModel? userModel = await authRepository.getUserFromDatabase(
        authValue: emailOrPhone, isMobile: isPhone);
    if (userModel != null) {
      return userModel.email ?? "";
    } else {
      return "";
    }
  }

  Future<void> _getAllUsers(GetAllUsers event, Emitter<AuthState> emit) async {
    List<UserModel> userList = await authRepository.getAllUsers();
    print(userList);
  }

  Future<void> _getAllOtpCollection(
      GetAllOtpCollection event, Emitter<AuthState> emit) async {
    List<OTPLimitationModel> otpList =
        await authRepository.getAllOTPLimitationList();
    print(otpList);
  }

  Future<void> _deleteAnyCollection(
      DeleteAnyCollection event, Emitter<AuthState> emit) async {
    await authRepository.deleteAnyCollection(
        collectionName: event.collectionName);
  }
}
