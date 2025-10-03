import 'package:blog_app_bloc/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app_bloc/core/secrets/app_secrets.dart';
import 'package:blog_app_bloc/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:blog_app_bloc/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app_bloc/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app_bloc/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app_bloc/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app_bloc/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app_bloc/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app_bloc/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app_bloc/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:blog_app_bloc/features/blog/domain/reopsitories/blog_repository.dart';
import 'package:blog_app_bloc/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog_app_bloc/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);

  //core
  serviceLocator.registerLazySingleton(
    () => AppUserCubit(),
  );
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(serviceLocator()),
    )
    ..registerLazySingleton(
      () => AuthBloc(
        userSignup: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initBlog() {
  //Datasourcs
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    //Repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        serviceLocator(),
      ),
    )
    //Usecase
    ..registerFactory(
      () => UploadBlog(
        serviceLocator(),
      ),
    )
    //Bloc
    ..registerFactory(
      () => BlogBloc(
        serviceLocator(),
      ),
    );
}
