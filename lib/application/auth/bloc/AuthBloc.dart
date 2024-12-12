

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../repositories/AuthRepository.dart';
import 'AuthEvent.dart';
import 'AuthState.dart';

@Singleton()
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    // Parent side flow
  }


}
