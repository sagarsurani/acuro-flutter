import 'package:acuro/core/constants/Constants.dart';
import 'package:acuro/models/Auth/UserModel.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SendOtpEvent extends AuthEvent {
  final String phoneNumber;
  final bool isFromForgot;

  const SendOtpEvent({required this.phoneNumber, required this.isFromForgot});
}

class VerifyOtpEvent extends AuthEvent {
  final String verificationId;
  final String smsCode;

  const VerifyOtpEvent({required this.verificationId, required this.smsCode});
}

class ResendOtpEvent extends AuthEvent {
  final String phoneNumber;
  final bool isFromForgot;

  const ResendOtpEvent({required this.phoneNumber, required this.isFromForgot});
}

class EmailAuthSignUpEvent extends AuthEvent {
  final UserModel userData;
  final String email;
  final String password;

  const EmailAuthSignUpEvent(
      {required this.email, required this.userData, required this.password});
}

class LoginAuthEvent extends AuthEvent {
  final LoginType loginType;
  final String emailOrPhone;
  final String password;

  const LoginAuthEvent(
      {required this.emailOrPhone,
      required this.loginType,
      required this.password});
}

class GetAllUsers extends AuthEvent {}

class GetAllOtpCollection extends AuthEvent {}

class DeleteAnyCollection extends AuthEvent {
  final String collectionName;

  const DeleteAnyCollection({required this.collectionName});
}

class ResetPassword extends AuthEvent {
  final String emailOrPhone;
  final bool isPhone;
  final String password;

  const ResetPassword(
      {required this.emailOrPhone,
      required this.password,
      required this.isPhone});
}
