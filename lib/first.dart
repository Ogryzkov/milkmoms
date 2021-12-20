import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'dart:io';

class First extends StatefulWidget {
  const First({Key? key}) : super(key: key);

  @override
  _FirstState createState() => _FirstState();
}


class _FirstState extends State<First> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Center(child: Text('First Screen')),
        Placeholder(),
        ElevatedButton(onPressed: (){
          Navigator.of(context).pushNamed('/scnd');

        },
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.all(10)),
              backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(
                  114, 120, 238, 0.807843137254902)),
              // backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(
              //          114, 120, 238, 0.85)),
              //shadowColor: MaterialStateProperty.all(Colors.black),
              elevation: MaterialStateProperty.all(2.0),
              overlayColor: MaterialStateProperty.all(const Color.fromRGBO(
                  227, 229, 255, 0.5411764705882353)),
              shadowColor: MaterialStateProperty.all(const Color.fromRGBO(
                  114, 120, 238, 0.0)),
              shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(200),
                    //side: BorderSide(color: Colors.blue),
                  )
              ),
              minimumSize: MaterialStateProperty.all(Size.fromRadius(50)),
            ),
            child: Text('text')),

        ElevatedButton(onPressed: () {
          //FlutterAlarmClock.createAlarm(120, 00);
          //getDB();



        },
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.all(10)),
              backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(
                  114, 120, 238, 0.807843137254902)),
              // backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(
              //          114, 120, 238, 0.85)),
              //shadowColor: MaterialStateProperty.all(Colors.black),
              elevation: MaterialStateProperty.all(2.0),
              overlayColor: MaterialStateProperty.all(const Color.fromRGBO(
                  227, 229, 255, 0.5411764705882353)),
              shadowColor: MaterialStateProperty.all(const Color.fromRGBO(
                  114, 120, 238, 0.0)),
              shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(200),
                    //side: BorderSide(color: Colors.blue),
                  )
              ),
              minimumSize: MaterialStateProperty.all(Size.fromRadius(50)),
            ),
            child: Text('DB')),

        Center(child: Text('tap to go forward')),
      ],),
    );
  }
}


// class DbHelper {
//   DbHelper._privateConstructor();
//   static final DbHelper instance =  DbHelper._privateConstructor();
//
//   static Database? _database;
//   Future<Database> get database async => _database ??= await _initDatabase();
//
//   Future<Database> _initDatabase() async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join (documentsDirectory.path,)
//   }
// }