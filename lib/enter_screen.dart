import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dbhelper.dart';
import 'globals.dart' as globals;

class Enter extends StatefulWidget {
  const Enter({Key? key}) : super(key: key);

  @override
  _EnterState createState() => _EnterState();
}


var _logintxt;
var _passwtxt;

class _EnterState extends State<Enter> {

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
            _buildAuthButton(context)
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

Widget _buildAuthButton(context) => GestureDetector(//ВХОД
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
    int id = await DatabaseHelper.instance.getIdFromAccount(_logintxt,_passwtxt);
    print (id);


    //await regenerateDonor();
    //Navigator.pushReplacementNamed(context, "/frst");
    if (id != null) {
      DatabaseHelper.instance.AddRegistered();

      DatabaseHelper.instance.setRegistered(1, id);//устанавливает активного пользователя State, id_account
      //DatabaseHelper.instance.getInfoRegistered();//возвращает пару id_account, state
      int state = await DatabaseHelper.instance.RegisteredState();//возвращает состояние регистрации 0 и 1
      print(state);
      if (state==1) Navigator.pushReplacementNamed(context, "/frst");
    }

    // else {
    // }

    // var b = await DatabaseHelper.instance.getInfoFromDonor();
    // var A = b.map((e) => e.F_name).elementAt(0).toString();
    // print(A);

    //DatabaseHelper.instance.addNation();
    //DatabaseHelper.instance.getInfoFromDonor(5);

    //DatabaseHelper.instance.DropTable('Donor');
    //DatabaseHelper.instance.createTable();

    //print(a);
    //DatabaseHelper.instance.addNation();
    //DatabaseHelper.instance.getInfoCustomer(id);
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


Future<void> regenerateDonor() async {
  await DatabaseHelper.instance.DropTable('Donor');
  await DatabaseHelper.instance.createTable();
  var a1 = await DatabaseHelper.instance.addDonor('Виктория','Петрова','1985-05-21','Луговая', '5', 200, 1, 4, '5121649166602513','7968589626', 96612, '2021-06-22', '2022-06-22');
  var a2 = await DatabaseHelper.instance.addDonor('Анжелика','Иванова','1983-01-02','Оренбургская', '12', 250, 1, 4, '5369909261118893','7913952237', 11542, '2021-03-22', '2022-03-22');
  var a3 = await DatabaseHelper.instance.addDonor('Елизавета','Зарица','1993-02-18','Советская', '61', 300, 7, 5, '5121649010216999','7906261451', 16482, '2021-09-19', '2022-09-19');
  var a4 = await DatabaseHelper.instance.addDonor('Марьямна','Кугушева','1988-05-05','Пушкинская', '121', 200, 2, 3, '5323570151567303','7975956572', 12516, '2021-01-05', '2022-01-05');
  var a5 = await DatabaseHelper.instance.addDonor('Римма','Койначёнока','1992-08-19','Уральская', '13', 250, 1, 5, '5404370884368695','7927845561', 19548, '2021-08-09', '2022-08-09');
  var a6 = await DatabaseHelper.instance.addDonor('Александра','Саблина','1990-05-16','Тютчева', '85', 280, 4, 2, '5324207882403081','7990517003', 56848, '2021-02-01', '2022-02-01');
  var a7 = await DatabaseHelper.instance.addDonor('Ева','Базина','1994-01-10','Угольная', '4', 320, 7, 1, '5315785609657320','7961943728', 13068, '2021-02-05', '2022-02-05');
  var a8 = await DatabaseHelper.instance.addDonor('Любовь','Невская','1990-05-19','Кривая', '18', 350, 3, 5, '5315770813644132','7936494363', 51357, '2021-03-06', '2022-03-06');
  var a9 = await DatabaseHelper.instance.addDonor('Людмила','Кубышкина','1984-12-13','Володская', '103', 400, 1, 5, '5324203222639401','7965040736', 51568, '2021-05-09', '2022-05-09');
  var a10 = await DatabaseHelper.instance.addDonor('Альбина','Ярная','1992-02-21','Нижняя', '89', 250, 2, 3, '5127173678805849','7943927566', 46258, '2021-08-08', '2022-08-08');
  print(a10);
}//ПЕРЕСОЗДАНИЕ ТАБЛИЦЫ ДОНОР




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
