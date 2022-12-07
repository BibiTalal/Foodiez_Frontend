import 'package:flutter/material.dart';
import 'package:foodiez_frontent/models/dishes.dart';
import 'package:go_router/go_router.dart';
import 'package:foodiez_frontent/screens/signin.dart';
import 'package:foodiez_frontent/screens/signup.dart';
import 'package:foodiez_frontent/screens/home.dart';
import 'package:foodiez_frontent/screens/welcome.dart';
import 'package:foodiez_frontent/providers/cuisine_provider.dart';
import 'package:provider/provider.dart';
import 'package:foodiez_frontent/providers/dishes_provider.dart';
import 'package:foodiez_frontent/screens/dishes.dart';
import 'package:foodiez_frontent/screens/addcuisine.dart';
import 'package:foodiez_frontent/providers/auth_provider.dart';
import 'package:foodiez_frontent/screens/adddishes.dart';

void main() {
  runApp(
    MyApp(),
  );
}

final router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => HomeScreen(),
  ),
  GoRoute(
    path: '/signup',
    builder: (context, state) => SignUp(),
  ),
  GoRoute(
    path: '/signin',
    builder: (context, state) => SignIn(
        // password: state.extra as String,
        ),
  ),
  GoRoute(
    path: '/welcome',
    builder: (context, state) => Welcome(
      username: state.extra as String,
    ),
  ),
  GoRoute(
    path: '/dishes',
    builder: (context, state) => DishScreen(),
  ),
  GoRoute(
    path: '/addcuisine',
    builder: (context, state) => AddCuisineScreen(),
  ),
  GoRoute(
    path: '/adddish',
    builder: (context, state) => AddDishScreen(),
  ),
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DishProvider()),
        ChangeNotifierProvider(create: (context) => CuisineProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      // This is the theme of your application.
      //
      // Try running your application with "flutter run". You'll see the
      // application has a blue toolbar. Then, without quitting the app, try
      // changing the primarySwatch below to Colors.green and then invoke
      // "hot reload" (press "r" in the console where you ran "flutter run",
      // or simply save your changes to "hot reload" in a Flutter IDE).
      // Notice that the counter didn't reset back to zero; the application
      // is not restarted.
      child: MaterialApp.router(
        theme: ThemeData(primarySwatch: Colors.blue),
        routerConfig: router,
      ),
    );
  }
}
