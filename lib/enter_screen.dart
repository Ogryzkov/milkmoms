import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dbhelper.dart';

class Enter extends StatefulWidget {
  const Enter({Key? key}) : super(key: key);

  @override
  _FirstState createState() => _FirstState();
}

var _logintxt;
var _passwtxt;

class _FirstState extends State<Enter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLogo(),
          Center(child: _buildLogin()),
          Center(child: _buildPassword()),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
            _buildEnterButton(context),
            _buildAuthButton()
          ],)//две кнопки





        ],

      ),


    );
  }
}

Widget _buildLogo() => Container(
  margin: const EdgeInsets.only(top: 0 ,bottom: 0),
  width: 200,
  height: 200,
  child: Image.asset("assets/milkmomsOp.png", colorBlendMode: BlendMode.lighten,),
);

Widget _buildLogin() => Container(
  alignment: Alignment.center,
  padding: EdgeInsets.all(4.0),
  margin: EdgeInsets.only(top: 0, bottom: 2),
  height: 70.0,
  width: 300,
  clipBehavior : Clip.antiAlias,
  decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(80)),
      color: Color.fromRGBO(0, 0, 0, 0.058823529411764705)
  ),

  child: Row(
    children: <Widget>[
      Flexible(
        flex: 2,
        child: TextFormField(
            onChanged: (text){
              _logintxt = text;
            },
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 16.0, color: Color.fromRGBO(
              88, 88, 88, 1.0)),
          decoration:
          const InputDecoration(
            prefixIcon: Padding(
                padding: EdgeInsets.all(0.0),
                child: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.grey,
                ), // icon is 48px widget.
              ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              borderSide: BorderSide(
                  color: Color.fromRGBO(115, 127, 137, 1.0), width: 2.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              borderSide: BorderSide(
                  color: Color.fromRGBO(96, 163, 199, 1.0), width: 2.5),
            ),
            hintText: 'Логин',
            hintStyle: TextStyle(fontSize: 14.0)
          ),

        ),
      ),
    ],
  ),
);// Контейнер с логином

Widget _buildPassword() => Container(
  alignment: Alignment.center,
  padding: EdgeInsets.all(4.0),
  margin: EdgeInsets.symmetric(vertical: 2),
  height: 70.0,

  width: 300,
  clipBehavior : Clip.antiAlias,
  decoration: const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(80)),
    color: Color.fromRGBO(0, 0, 0, 0.058823529411764705)
  ),

  child: Row(
    children: <Widget>[
      Flexible(
        flex: 2,
        child: TextField(
          onChanged: (text){
            _passwtxt = text;
          },
          obscureText: true,
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 16.0, color: Color.fromRGBO(
              88, 88, 88, 1.0)),
          decoration:
          const InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsets.all(0.0),
                child: Icon(
                  Icons.more_horiz,
                  color: Colors.grey,
                ), // icon is 48px widget.
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                borderSide: BorderSide(
                    color: Color.fromRGBO(115, 127, 137, 1.0), width: 2.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                borderSide: BorderSide(
                    color: Color.fromRGBO(96, 163, 199, 1.0), width: 2.5),
              ),
              hintText: 'Пароль',
              hintStyle: TextStyle(fontSize: 14.0)
          ),

        ),
      ),
    ],
  ),
);// Контейнер с паролем

Widget _buildEnterButton(context) => GestureDetector(//РЕГИСТРАЦИЯ
    child:   Container(
      child: const Text("Регистрация",
          style: TextStyle(fontSize: 15.0, color: Color.fromRGBO(
              88, 88, 88, 1.0)),),
    alignment: Alignment.center,
    padding: EdgeInsets.all(0.0),
    margin: EdgeInsets.only(top: 10, bottom: 90),
    height: 30.0,
    width: 130,
    clipBehavior : Clip.antiAlias,
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(80)),
        color: Color.fromRGBO(0, 0, 0, 0.30196078431372547)
    ),
  ),
  onTap: () async {
      Navigator.of(context).pushNamed('/auth');
      //DatabaseHelper.instance.createTable();
      //DatabaseHelper.instance.getInfo(_logintxt.toString(),_passwtxt.toString());
      //DatabaseHelper.instance.deleteRaw(2);
    //DatabaseHelper.instance.add(logintxt, passwtxt);
      //DatabaseHelper.instance.DropTable("Account");
    //print ("Tap on container");
  },
);

Widget _buildAuthButton() => GestureDetector(//ВХОД
  child:   Container(
    child: const Text("Вход",
      style: TextStyle(fontSize: 15.0, color: Color.fromRGBO(
          88, 88, 88, 1.0)),),
    alignment: Alignment.center,
    padding: EdgeInsets.all(0.0),
    margin: EdgeInsets.only(top: 10, bottom: 90, left: 15),
    height: 30.0,
    width: 105,
    clipBehavior : Clip.antiAlias,
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(80)),
        color: Color.fromRGBO(0, 0, 0, 0.25098039215686274)
    ),
  ),
  onTap: () async {
    //DatabaseHelper.instance.getInfo();
    //DatabaseHelper.instance.add1();
    //DatabaseHelper.instance.createTable();
    //DatabaseHelper.instance.getInfo(_logintxt.toString(),_passwtxt.toString());
    //DatabaseHelper.instance.deleteRaw(2);
    //DatabaseHelper.instance.add(_logintxt, _passwtxt);
    //DatabaseHelper.instance.DropTable("Account");
    print ("Tap on container");
  },
);







// ElevatedButton(onPressed: (){
// Navigator.of(context).pushNamed('/scnd');
//
// },
// style: ButtonStyle(
// padding: MaterialStateProperty.all(EdgeInsets.all(10)),
// backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(
// 114, 120, 238, 0.807843137254902)),
// // backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(
// //          114, 120, 238, 0.85)),
// //shadowColor: MaterialStateProperty.all(Colors.black),
// elevation: MaterialStateProperty.all(2.0),
// overlayColor: MaterialStateProperty.all(const Color.fromRGBO(
// 227, 229, 255, 0.5411764705882353)),
// shadowColor: MaterialStateProperty.all(const Color.fromRGBO(
// 114, 120, 238, 0.0)),
// shape: MaterialStateProperty.all(
// RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(200),
// //side: BorderSide(color: Colors.blue),
// )
// ),
// minimumSize: MaterialStateProperty.all(Size.fromRadius(50)),
// ),
// child: Text('text')),
