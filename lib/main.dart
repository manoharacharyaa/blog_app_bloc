import 'package:blog_app_bloc/core/secrets/app_secrets.dart';
import 'package:blog_app_bloc/core/theme/theme.dart';
import 'package:blog_app_bloc/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:blog_app_bloc/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app_bloc/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app_bloc/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app_bloc/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            userSignup: UserSignUp(
              AuthRepositoryImpl(
                AuthRemoteDataSourceImpl(supabase.client),
              ),
            ),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: const LoginPage(),
    );
  }
}
