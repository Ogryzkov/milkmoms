import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dbhelper.dart';


class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);
  @override
  _FirstState createState() => _FirstState();
}
String Reg = "Зарегистрироваться";
bool isRegistr = false;
late String _logintxt;
late String _passwtxt;
var name;
var surname;
var street;
var aps;
var requits;
var tel;



class _FirstState extends State<Auth> {
  double H = 60;
  double W = 220;
  double fontSize = 15;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          //color: Color.fromRGBO(0, 0, 0, 0.2),
          width: 400,
          height: 800,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLogo(),
              // Container(
              // width: 260,
              //   padding: const EdgeInsets.all(3),
              //   margin: const EdgeInsets.all(5),
              //   child: const Text("Заполните каждое поле",
              //     style: TextStyle(
              //         fontSize: 19,
              //         color: Color.fromRGBO(0, 0, 0, 0.5490196078431373)
              //     ),),
              // ),//придумайте логин
              Center(child: _buildLogin(H,W,fontSize)),
              Center(child: _buildPassword(H,W,fontSize)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: _buildFirstName(H-5,W-70,fontSize)),
                  Center(child: _buildLastName(H-5,W-70,fontSize)),
                ],),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                _buildStreet(H-5,W-60,fontSize),
                _buildApart(H-5,W-120,fontSize),
              ],),
              Center(child: _buildRequisites(H,W+50,fontSize)),
              Center(child: _buildTel(H-5,W,fontSize)),
              //_buildEnterButton(),

              GestureDetector(
                child:   Container(
                  child: Text(Reg,
                    style: const TextStyle(fontSize: 16.0, color: Color.fromRGBO(
                        88, 88, 88, 1.0)),),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(0.0),
                  margin: const EdgeInsets.only(top: 10, bottom: 50),
                  height: 40.0,
                  width: 225,
                  clipBehavior : Clip.antiAlias,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(80)),
                      color: Color.fromRGBO(0, 0, 0, 0.25098039215686274)
                  ),
                ),
                onTap: () async {
                  if (isRegistr==false) {
                    // await DatabaseHelper.instance.addAccount(_logintxt, _passwtxt);
                    //
                    int id = await DatabaseHelper.instance.getInfo(_logintxt,_passwtxt);
                    // DatabaseHelper.instance.addCustomer(id, name, surname,street, aps, requits, tel);
                    DatabaseHelper.instance.getInfoCustomer(id);


                    //DatabaseHelper.instance.add(_logintxt, _passwtxt);
                    //DatabaseHelper.instance.getInfo(_logintxt, _passwtxt);
                   // isRegistr=true;
                  }
                //   else {
                //     setState(() {
                //     Reg = "Уже зарегистрированы";
                //   });
                // }

                //DatabaseHelper.instance.createTable();Navigator.of(context).pushNamed('/frst');
                //DatabaseHelper.instance.getInfo(_logintxt.toString(),passwtxt.toString());
                //DatabaseHelper.instance.deleteRaw(2);
                //DatabaseHelper.instance.add(logintxt, passwtxt);
                //DatabaseHelper.instance.DropTable("Account");
                print ("Tap on container");
              },
            ),//Кнопка регистрации




            ],

          ),
        ),
      ),


    );
  }
}

Widget _buildLogo() => Container(
  margin: const EdgeInsets.only(top: 0 ,bottom: 0),
  width: 170,
  height: 170,
  child: Image.asset("assets/milkmomsOp.png", colorBlendMode: BlendMode.lighten,),
);//Картинка

Widget _buildLogin(double H, double W, double fontSize) => Container(
  height: H,
  width: W,
  alignment: Alignment.center,
  padding: EdgeInsets.all(4.0),
  margin: EdgeInsets.only(top: 0, bottom: 8),
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
          style: TextStyle(fontSize: fontSize, color: Color.fromRGBO(
              88, 88, 88, 1.0)),
          decoration:
          InputDecoration(
              prefixIcon: const Padding(
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
              hintStyle: TextStyle(fontSize: fontSize)
          ),

        ),
      ),
    ],
  ),
);// Контейнер с логином

Widget _buildPassword(double H, double W,double fontSize) => Container(
  height: H,
  width: W,
  alignment: Alignment.center,
  padding: EdgeInsets.all(4.0),
  margin: EdgeInsets.only(top: 0, bottom: 8),
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
          style: TextStyle(fontSize: fontSize, color: Color.fromRGBO(
              88, 88, 88, 1.0)),
          decoration:
          InputDecoration(
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
              hintStyle: TextStyle(fontSize: fontSize)
          ),

        ),
      ),
    ],
  ),
);// Контейнер с паролем

Widget _buildFirstName(double H, double W, double fontSize) => Container(
  height: H,
  width: W,
  alignment: Alignment.center,
  padding: EdgeInsets.all(4.0),
  margin: EdgeInsets.only(top: 0, bottom: 8),
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
            name = text;
          },
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: fontSize, color: Color.fromRGBO(
              88, 88, 88, 1.0)),
          decoration:
          InputDecoration(
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
              hintText: 'Имя',
              hintStyle: TextStyle(fontSize: fontSize)
          ),

        ),
      ),
    ],
  ),
);// имя

Widget _buildLastName(double H, double W, double fontSize) => Container(
  height: H,
  width: W,
  alignment: Alignment.center,
  padding: EdgeInsets.all(4.0),
  margin: EdgeInsets.only(top: 0, bottom: 8,left: 8),
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
            surname = text;
          },
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: fontSize, color: Color.fromRGBO(
              88, 88, 88, 1.0)),
          decoration:
          InputDecoration(
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
              hintText: 'Фамилия',
              hintStyle: TextStyle(fontSize: fontSize)
          ),

        ),
      ),
    ],
  ),
);// Фамилия

Widget _buildStreet(double H, double W, double fontSize) => Container(
  height: H,
  width: W,
  alignment: Alignment.center,
  padding: EdgeInsets.all(4.0),
  margin: EdgeInsets.only(top: 0, bottom: 8),
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
            street = text;
          },
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: fontSize, color: Color.fromRGBO(
              88, 88, 88, 1.0)),
          decoration:
          InputDecoration(
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
              hintText: 'Улица',
              hintStyle: TextStyle(fontSize: fontSize)
          ),

        ),
      ),
    ],
  ),
);// Адресс Улица

Widget _buildApart(double H, double W, double fontSize) => Container(
  height: H,
  width: W,
  alignment: Alignment.center,
  padding: EdgeInsets.all(4.0),
  margin: EdgeInsets.only(top: 0, bottom: 8, left: 8),
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
            aps = text;
          },
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: fontSize, color: Color.fromRGBO(
              88, 88, 88, 1.0)),
          decoration:
          InputDecoration(
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
              hintText: 'Дом',
              hintStyle: TextStyle(fontSize: fontSize)
          ),

        ),
      ),
    ],
  ),
);// Адрес Дом

Widget _buildRequisites(double H, double W, double fontSize) => Container(
  height: H,
  width: W,
  padding: EdgeInsets.all(4.0),
  margin: EdgeInsets.only(top: 0, bottom: 8),
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
            requits = text;
          },
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: fontSize, color: Color.fromRGBO(
              88, 88, 88, 1.0)),
          decoration:
          InputDecoration(
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
              hintText: 'Реквизиты',
              hintStyle: TextStyle(fontSize: fontSize)
          ),

        ),
      ),
    ],
  ),
);// реквизиты

Widget _buildTel(double H, double W, double fontSize) => Container(
  height: H,
  width: W,
  alignment: Alignment.center,
  padding: EdgeInsets.all(4.0),
  margin: EdgeInsets.only(top: 0, bottom: 8),

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
            tel = text;
          },
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: fontSize, color: Color.fromRGBO(
              88, 88, 88, 1.0)),
          decoration:
          InputDecoration(
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
              hintText: 'Телефон',
              hintStyle: TextStyle(fontSize: fontSize)
          ),

        ),
      ),
    ],
  ),
);// Телефон






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
