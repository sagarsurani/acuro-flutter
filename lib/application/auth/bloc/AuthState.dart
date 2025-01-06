
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}


// 1

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String errorMessage;

  const AuthError({required this.errorMessage});
}

class AuthOtpSent extends AuthState {
  final String verificationId;

  const AuthOtpSent({required this.verificationId});
}


//2

class AuthVerifyLoading extends AuthState {}

class AuthVerifyError extends AuthState {
  final String errorMessage;

  const AuthVerifyError({required this.errorMessage});
}

class AuthVerified extends AuthState {
  final UserCredential? userCredential;

  const AuthVerified({this.userCredential});
}

class ResendOtpSend extends AuthState {
  final String verificationId;

  const ResendOtpSend({required this.verificationId});
}


//3

class LoginAuthLoading extends AuthState {}


class LoginAuthError extends AuthState {
  final String errorMessage;

  const LoginAuthError({required this.errorMessage});
}

class LoginAuthDone extends AuthState {
  final UserCredential? userCredential;

  const LoginAuthDone({this.userCredential});
}

class EmailAuthDone extends AuthState {
  final UserCredential? userCredential;

  const EmailAuthDone({this.userCredential});
}


//4

class EmailAuthLoading extends AuthState {}

class EmailAuthError extends AuthState {
  final String errorMessage;

  const EmailAuthError({required this.errorMessage});
}

class AuthEmailOtpSent extends AuthState {
  final String verificationId;

  const AuthEmailOtpSent({required this.verificationId});
}

class EmailAuthVerified extends AuthState {
  // final UserCredential? userCredential;
  //
  // const EmailAuthVerified({this.userCredential});
}

// 5
class ResetAuthLoading extends AuthState {}

class ResetPasswordError extends AuthState {
  final String errorMessage;

  const ResetPasswordError({required this.errorMessage});
}

class ResetPasswordDone extends AuthState {}






