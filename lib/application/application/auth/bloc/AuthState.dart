import 'package:acuro/core/constants/Constants.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthVerifyLoading extends AuthState {}

class AuthOtpSent extends AuthState {
  final String verificationId;

  const AuthOtpSent({required this.verificationId});
}

class ResendOtpSend extends AuthState {
  final String verificationId;

  const ResendOtpSend({required this.verificationId});
}

class AuthVerified extends AuthState {
  final UserCredential? userCredential;

  const AuthVerified({this.userCredential});
}

class AuthError extends AuthState {
  final String errorMessage;

  const AuthError({required this.errorMessage});
}

class EmailAuthDone extends AuthState {
  final UserCredential? userCredential;

  const EmailAuthDone({this.userCredential});
}

class LoginAuthDone extends AuthState {
  final UserCredential? userCredential;

  const LoginAuthDone({this.userCredential});
}

