import 'package:go_router/go_router.dart';

import '../screens/home/home_supabase.dart';
import '../screens/login/login_screen.dart';
import '../screens/sign_up/sign_up.dart';
import '../screens/splash/splash_screen.dart';

class RouterHelper {
  static const String splash = '/';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String homeSupabase = '/home-supabase';

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: signUp,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: homeSupabase,
        builder: (context, state) => const HomeSupabase(),
      )
    ],
  );
}
