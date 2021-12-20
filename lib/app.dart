import 'package:flutter/material.dart';
import 'package:milkmoms/first.dart';
import 'package:milkmoms/second.dart';

import 'auth_screen.dart';
import 'enter_screen.dart';



class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/frst': (context) => const First(),
        '/scnd': (context) => const Second(),
        '/enter': (context) => const Enter(),
        '/auth': (context) => const Auth(),


      },
      initialRoute: '/enter',
    );
  }
}
