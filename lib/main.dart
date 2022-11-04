import 'package:flutter/material.dart';
import 'package:appmymystore/routes.dart';
import 'package:appmymystore/screens/profile/profile_screen.dart';
import 'package:appmymystore/screens/splash/splash_screen.dart';
import 'package:appmymystore/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
