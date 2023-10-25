import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tutorials_project/supabase/services/auth_services.dart';

import '../../../componnets/custom_snackbar.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: email,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              TextField(
                controller: password,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Dont\'t have account? '),
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                color: Colors.deepPurple,
                textColor: Colors.white,
                onPressed: () {
                  if (email.text.isNotEmpty && password.text.isNotEmpty) {
                    AuthServices()
                        .signIn(
                      email: email.text,
                      password: password.text,
                    )
                        .then((value) {
                      context.go('/home-supabase');
                      showSnackBar(context, 'User Logged In');
                    }).onError((error, stackTrace) {
                      log(error.toString());
                      showSnackBar(context, error.toString());
                    });
                  } else {
                    showSnackBar(context, 'All Fields required');
                  }
                },
                child: const Text('Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
