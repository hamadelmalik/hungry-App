import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/features/auth/cubit/auth_cubit.dart';
import 'package:hungry/features/auth/view/login_view.dart';
import 'package:hungry/features/home/cubit/home_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

        providers: [

        BlocProvider(create: (context) => AuthCubit(),),
       BlocProvider(create: (context) => HomeCubit(),),
],
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'hungerApp',
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        home: LoginView(),
      ),
    );
  }
}
