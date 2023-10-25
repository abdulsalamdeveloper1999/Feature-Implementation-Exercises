import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tutorials_project/supabase/utils/constants.dart';

import 'flutter_bloc_toturial/logic/bloc/post_bloc.dart';
import 'flutter_bloc_toturial/views/post_api.dart';

Box? box;

void main() async {
  ///
  ///Regitser adapter firstb
  ///
  ///Hive
  // WidgetsFlutterBinding.ensureInitialized();
  // final directory = await getApplicationDocumentsDirectory();
  // Hive.init(directory.path);

  // Hive.registerAdapter(EmployeeModelAdapter());
  // box = await Hive.openBox<EmployeeModel>("EmployeeModelbox");
  ///Hive
  ///
  ///Supabase
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    anonKey: AppConstants.supabseKey,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //.router is from gorouter
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),

      ///
      //go router
      // routerConfig: RouterHelper.router,

      ///
      // home: const SqfliteFetch(),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PostBloc(),
          )
        ],
        child: const PostapiScreen(),
      ),
      // home: const NodeApiScreen(),
      // home: const EmployeeScreen(),
      // home: const SignUpScreen(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// ///MvVM
// void main() {
//   runApp(const MyAppMvvm());
// }
//
// class MyAppMvvm extends StatelessWidget {
//   const MyAppMvvm({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => AuthViewModel()),
//         ChangeNotifierProvider(create: (_) => UserViewModel()),
//       ],
//       child: MaterialApp.router(
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(primarySwatch: Colors.deepPurple),
//         routerConfig: RouterHelper.router,
//       ),
//     );
//   }
// }
