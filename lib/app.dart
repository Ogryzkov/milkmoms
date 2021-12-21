import 'package:flutter/material.dart';
import 'package:milkmoms/first.dart';
import 'package:milkmoms/second.dart';
import 'dbhelper.dart';
import 'auth_screen.dart';
import 'enter_screen.dart';
import 'globals.dart' as globals;



class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}


class _AppState extends State<App> {



  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //initState();

    return MaterialApp(
      routes: {
        '/frst': (context) => const First(),
        '/scnd': (context) => const Second(),
        '/enter': (context) => const Enter(),
        '/auth': (context) => const Auth(),


      },

      initialRoute: '/enter'
    );
  }

}

