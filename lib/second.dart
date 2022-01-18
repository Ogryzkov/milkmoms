import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:milkmoms/tablesclasses.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dbhelper.dart';


class Second extends StatefulWidget {
  const Second({Key? key}) : super(key: key);

  @override
  _SecondState createState() => _SecondState();
}


String Change = "Сохранить";
bool isRegistr = false;
late String _logintxt;
late String _passwtxt;
var name = "a";
var surname = "a";
var street = "a";
var aps = "a";
var requits = "a";
var tel = "a";



class _SecondState extends State<Second> {
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
              FutureBuilder<List<Registered>>(
                  future: DatabaseHelper.instance.getInfoFromRegistered(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Registered>> snapshot) {
                    return
                      FutureBuilder<List<Customer>>(
                        future: DatabaseHelper.instance.getInfoFromOneCustomer(snapshot.data!.map((e) => e).toList().first.id_account!),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Customer>> snapshot) {
                            return Column(children: [
                              Container( height: 75,
                                  alignment: Alignment.center,
                                  //color: Colors.red,
                                  child: Text('Информация об аккаунте', style: style(17),)
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(child: _buildFirstName(H-5,W-70,fontSize,snapshot.data!.map((e) => e).toList().first.F_name )),
                                  Center(child: _buildLastName(H-5,W-70,fontSize, snapshot.data!.map((e) => e).toList().first.L_name)),
                                ],),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildStreet(H-5,W-60,fontSize, snapshot.data!.map((e) => e).toList().first.Street),
                                  _buildApart(H-5,W-120,fontSize, snapshot.data!.map((e) => e).toList().first.Apartment),
                                ],),
                              Center(child: _buildRequisites(H,W+50,fontSize, snapshot.data!.map((e) => e).toList().first.Requisites)),
                              Center(child: _buildTel(H-5,W,fontSize, snapshot.data!.map((e) => e).toList().first.Tel)),

                              GestureDetector(
                                child:   Container(
                                  child: Text(Change,
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

                                  if(name=="a"){
                                    setState(() {
                                      name=snapshot.data!.map((e) => e).toList().first.F_name!;
                                    });
                                  }
                                  if(surname=="a"){
                                    setState(() {
                                      surname=snapshot.data!.map((e) => e).toList().first.F_name!;
                                    });
                                  }
                                  if(street=="a"){
                                    setState(() {
                                      street=snapshot.data!.map((e) => e).toList().first.Street!;
                                    });
                                  }
                                  if(aps=="a"){
                                    setState(() {
                                      aps=snapshot.data!.map((e) => e).toList().first.Apartment!;
                                    });
                                  }
                                  if(requits=="a"){
                                    setState(() {
                                      requits=snapshot.data!.map((e) => e).toList().first.Requisites!;
                                    });
                                  }
                                  if(tel=="a"){
                                    setState(() {
                                      tel=snapshot.data!.map((e) => e).toList().first.Tel!;
                                    });
                                  }

                                  if (isRegistr==false) {
                                    DatabaseHelper.instance.UpdateCustomer(name, surname, street, aps, requits, tel, snapshot.data!.map((e) => e).toList().first.id_account);
                                    isRegistr=true;
                                  }
                                  else {
                                    setState(() {
                                      Change = "Сохранено";
                                    });
                                  }
                                  print ("Tap on container");
                                },
                              ),//Кнопка сохранить данные об аккаунте

                            ],);

                        });

                  }),





            ],

          ),
        ),
      ),


    );
  }
}

TextStyle style (double sizef){
  return TextStyle(
    fontSize: sizef,
    color: Color.fromRGBO(0, 0, 0, 0.6509803921568628),
  );
}


// Widget _buildLogin(double H, double W, double fontSize, text) => Container(
//   height: H,
//   width: W,
//   alignment: Alignment.center,
//   padding: EdgeInsets.all(4.0),
//   margin: EdgeInsets.only(top: 0, bottom: 8),
//   clipBehavior : Clip.antiAlias,
//   decoration: const BoxDecoration(
//       borderRadius: BorderRadius.all(Radius.circular(80)),
//       color: Color.fromRGBO(0, 0, 0, 0.058823529411764705)
//   ),
//
//   child: Row(
//     children: <Widget>[
//       Flexible(
//         flex: 2,
//         child: TextFormField(
//           readOnly: true,
//           onChanged: (text){
//             _logintxt = text;
//           },
//           textAlign: TextAlign.left,
//           style: TextStyle(fontSize: fontSize, color: Color.fromRGBO(
//               88, 88, 88, 1.0)),
//           decoration:
//           InputDecoration(
//               prefixIcon: const Padding(
//                 padding: EdgeInsets.all(0.0),
//                 child: Icon(
//                   Icons.account_circle_outlined,
//                   color: Colors.grey,
//                 ), // icon is 48px widget.
//               ),
//               enabledBorder: const OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(50.0)),
//                 borderSide: BorderSide(
//                     color: Color.fromRGBO(115, 127, 137, 1.0), width: 2.5),
//               ),
//               focusedBorder: const OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(50.0)),
//                 borderSide: BorderSide(
//                     color: Color.fromRGBO(96, 163, 199, 1.0), width: 2.5),
//               ),
//               hintText: text,
//               hintStyle: TextStyle(fontSize: fontSize)
//           ),
//
//         ),
//       ),
//     ],
//   ),
// );// Контейнер с логином


Widget _buildFirstName(double H, double W, double fontSize, text) => Container(
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
          initialValue: text,
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
              hintText: text,
              hintStyle: TextStyle(fontSize: fontSize)
          ),

        ),
      ),
    ],
  ),
);// имя

Widget _buildLastName(double H, double W, double fontSize, text) => Container(
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
          initialValue: text,
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
              hintText: text,
              hintStyle: TextStyle(fontSize: fontSize)
          ),

        ),
      ),
    ],
  ),
);// Фамилия

Widget _buildStreet(double H, double W, double fontSize, text) => Container(
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
          initialValue: text,
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
              hintText: text,
              hintStyle: TextStyle(fontSize: fontSize)
          ),

        ),
      ),
    ],
  ),
);// Адресс Улица

Widget _buildApart(double H, double W, double fontSize, text) => Container(
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
          initialValue: text,
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
              hintText: text,
              hintStyle: TextStyle(fontSize: fontSize)
          ),

        ),
      ),
    ],
  ),
);// Адрес Дом

Widget _buildRequisites(double H, double W, double fontSize, text) => Container(
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
          initialValue: text,
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
              hintText: text,
              hintStyle: TextStyle(fontSize: fontSize)
          ),

        ),
      ),
    ],
  ),
);// реквизиты

Widget _buildTel(double H, double W, double fontSize,text) => Container(
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
          initialValue: text,
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
              hintText: text,
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
