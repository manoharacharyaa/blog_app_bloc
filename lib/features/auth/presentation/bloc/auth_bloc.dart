import 'package:blog_app_bloc/core/usecase/usecase.dart';
import 'package:blog_app_bloc/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app_bloc/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app_bloc/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_app_bloc/features/auth/domain/entities/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;

  AuthBloc({
    required UserSignUp userSignup,
    required UserLogin userLogin,
    required CurrentUser currentUser,
  }) : _userSignUp = userSignup,
       _userLogin = userLogin,
       _currentUser = currentUser,
       super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());
    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) {
        print(r.id);
        print(r.email);
        emit(AuthSucess(r));
      },
    );
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignUp(
      UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSucess(user)),
    );
  }

  void _onAuthLogin(event, emit) async {
    emit(AuthLoading());
    final res = await _userLogin(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );
    res.fold(
      (failure) {
        print('**************LOGIN FAILURE $failure');
        return emit(AuthFailure(failure.message));
      },
      (user) {
        print('*************Success $user');
        return emit(AuthSucess(user));
      },
    );
  }
}
