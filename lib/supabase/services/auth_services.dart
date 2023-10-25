import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServices {
  final supabase = Supabase.instance.client;

// Email and password sign up
  Future<void> signUp({required String email, required String password}) async {
    await supabase.auth.signUp(
      email: email,
      password: password,
    );
  }

// Email and password login
  Future<void> signIn({required String email, required String password}) async {
    await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

// // Magic link login
// await supabase.auth.signInWithOtp(email: 'my_email@example.com');

// Listen to auth state changes
  // void authState() {
  //   supabase.auth.onAuthStateChange.listen((data) {
  //     final AuthChangeEvent event = data.event;
  //     final Session? session = data.session;
  //     // Do something when there is an auth event
  //   });
  // }
}
