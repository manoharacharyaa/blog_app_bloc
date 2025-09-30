// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';
import 'package:blog_app_bloc/core/error/failure.dart';
import 'package:blog_app_bloc/core/usecase/usecase.dart';
import 'package:blog_app_bloc/core/common/entities/user.dart';
import 'package:blog_app_bloc/features/auth/domain/repository/auth_repository.dart';

class UserLogin implements UseCase<User, UserLoginParams> {
  final AuthRepository authRepository;
  UserLogin(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await authRepository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}
