import 'package:flutter/material.dart';
import 'package:milkmoms/first.dart';
import 'package:milkmoms/second.dart';



class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/frst': (context) => First(),
        '/scnd': (context) => Second()
      },
      initialRoute: '/frst',
    );
  }
}
