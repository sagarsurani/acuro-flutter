// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:acuro/application/application/auth/bloc/AuthBloc.dart' as _i510;
import 'package:acuro/application/application/auth/repositories/AuthRepository.dart'
    as _i1032;
import 'package:acuro/application/application/auth/repositories/AuthRepositoryImpl.dart'
    as _i683;
import 'package:acuro/core/interceptors/network_auth_interceptor.dart' as _i115;
import 'package:acuro/core/interceptors/network_error_interceptor.dart'
    as _i146;
import 'package:acuro/core/interceptors/network_log_interceptor.dart' as _i208;
import 'package:acuro/core/interceptors/network_refresh_interceptor.dart'
    as _i737;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt $initGetIt({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i737.NetworkRefreshInterceptor>(
        () => _i737.NetworkRefreshInterceptor());
    gh.singleton<_i208.NetworkLogInterceptor>(
        () => _i208.NetworkLogInterceptor());
    gh.singleton<_i146.NetworkErrorInterceptor>(
        () => _i146.NetworkErrorInterceptor());
    gh.singleton<_i115.NetworkAuthInterceptor>(
        () => _i115.NetworkAuthInterceptor());
    gh.lazySingleton<_i1032.AuthRepository>(() => _i683.AuthRepositoryImpl());
    gh.singleton<_i510.AuthBloc>(
        () => _i510.AuthBloc(authRepository: gh<_i1032.AuthRepository>()));
    return this;
  }
}
