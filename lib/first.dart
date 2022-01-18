import 'dart:ffi';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:intl/intl.dart';
import 'package:milkmoms/tablesclasses.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dbhelper.dart';
import 'globals.dart' as globals;

class First extends StatefulWidget {
  const First({Key? key}) : super(key: key);

  @override
  _FirstState createState() => _FirstState();
}


class _FirstState extends State<First> {
  int? selectedId;
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Scaffold.of(context).openDrawer();
              setState(() {

              });
            }),
        ),
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.6509803921568628),
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: (){
              Navigator.pushNamed(context, '/scnd');

            },
          ),
        ],)
      ),
      drawer:Container(// ЗАКАЗЫ
        width: 500,
        child: Drawer(
        child: Column (children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Text('Список заказов', style: style(20),),
            height: 80,
            padding: EdgeInsets.symmetric(vertical: 5),
            //color: Colors.grey,
          ),

              FutureBuilder<List<Orders>>(
                  future: DatabaseHelper.instance.getInfoFromOrder(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Orders>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: Text('Loading...'));
                    }
                    return snapshot.data!.isEmpty
                        ? Center(child: Text('No elements in List.'))
                        : Center(
                      child: Container(
                        width: 450,
                        height: 600,
                        child: ListView(
                          children: snapshot.data!.map((Orders) {
                            return Center(
                                child:
                                SizedBox(child: _buildOrder(Orders, context),
                                  width: 400,)
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  }),

          Container(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              child: Text('Обновить'),
              onPressed:(){

                setState(() {

                });
                } ,
            ),
            height: 80,
            padding: EdgeInsets.symmetric(vertical: 5),
            //color: Colors.grey,
          ),
        ],)
        ,),),
      body: Column(
        children: [
          Container( height: 75,
          alignment: Alignment.center,
          //color: Colors.red,
          child: Text('Нажмите на запись, чтобы создать заказ', style: style(17),)
          ),
        FutureBuilder<List<Donor>>(
            future: DatabaseHelper.instance.getInfoFromDonor(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Donor>> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text('Loading...'));
              }
              return snapshot.data!.isEmpty
                  ? Center(child: Text('No elements in List.'))
                  : Center(
                child: Container(
                  width: 450,
                  height: 600,
                  child: ListView(
                    children: snapshot.data!.map((Donor) {
                      return Center(
                          child:
                          SizedBox(child: _buildCard(Donor, context),
                            width: 470,)
                      );
                    }).toList(),
                  ),
                ),
              );
            }),

      ],)





    );

  }
}

Widget _buildOrder(Orders Orders, BuildContext ctx) => GestureDetector(//карточка заказа
  onTap: () async {
    Future.delayed(Duration(seconds: 60), () {
      DatabaseHelper.instance.UpdateProgress(Orders.id_order, "исполнено");
      print('delayed execution');
    });
    showModalBottomSheet(//Панель выезжающая снизу
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), //for the round edges
      builder: (context) {
        double H = 40;
        return Container(
            height: 250,

            //color: Color.fromRGBO(175, 43, 43, 1.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  _ContainerInfo("Дата заказа: ", Orders.start_order.toString(), H, 350),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _ContainerInfo("Объем, л: ", Orders.liter_value.toString(), H, 150),
                      _ContainerInfo("Стоимость: ", (Orders.liter_value*Orders.price_ful).toString(), H, 180),
                    ],
                  ),
                    _ContainerInfo("Статус: ", Orders.status, H, 190),

                ]) //what you want to have inside, I suggest using a column
        );
      },
      context: ctx,
      //isDismissible:  //boolean if you want to be able to dismiss it
      //isScrollControlled: //boolean if something does not display, try that
    );

    //await DatabaseHelper.instance.addAccount('nik', 000);
    //int a = await DatabaseHelper.instance.getIdFromAccount('nik', 000);
    //print(a);
    //print(a);
  },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _ContainerText(Orders.id_order.toString(), 45, 100),
        _ContainerText(Orders.status, 45, 170),
      ],));


Widget _buildCard(Donor Donor, BuildContext ctx) => GestureDetector(
  //Карточка отдельного донора
  onTap: () async {

    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), //for the round edges
        builder: (context) {
          double H = 40;
          return Container(
            height: 600,

              //color: Color.fromRGBO(175, 43, 43, 1.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    _ContainerInfo("Имя: ", Donor.F_name, H, 175),
                    _ContainerInfo("Фамилия: ", Donor.L_name, H, 235),
                  ],),
                ),
                  _ContainerInfo("Дата рождения: ",Donor.Bday, H, 300),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                    _ContainerInfo("Улица: ",Donor.Street, H, 200),
                      _ContainerInfo("Телефон: ",Donor.Tel, H, 210),
                  ],),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _ContainerInfo("Дом: ",Donor.Apartment.toString(), H, 100),
                      _ContainerInfo("Рекв.: ",Donor.Requisites, H, 250),
                    ],
                  ),
                ),

                _ContainerInfo("сертификат: ",Donor.id_Certificate.toString(), H, 200),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    _ContainerInfo("Годен с: ",Donor.Start_Certificate, H, 200),
                    _ContainerInfo("Годен до: ",Donor.Finish_Certificate, H, 200),
                  ],),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    _ContainerInfo("Цена л.: ",Donor.price_liter.toString(), H, 200),
                    GestureDetector(//ЗДЕСЬ СОЗДАЕТСЯ ЗАКАЗ
                        onTap:  (){
                          var random = new Random();
                          int rand = random.nextInt(8) + 1;
                          int rand2 = random.nextInt(3) + 1;
                          final String DatetimeCurrent =
                          DateFormat('yyyy-MM-dd - kk:mm:ss').format(DateTime.now()).toString();
                          DatabaseHelper.instance.transaction(Donor.id_donors, rand, DatetimeCurrent, DatetimeCurrent, rand2, Donor.price_liter, "в обработке");
                          },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(2),
                          margin: const EdgeInsets.only(top: 5, bottom: 10),
                          height: H,
                          width: 200,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color.fromRGBO(
                                  0, 0, 0, 0.21176470588235294),
                                width: 2,),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.2),
                                    offset: Offset(0.0, 2.5),
                                    blurRadius: 3,
                                    spreadRadius: 2
                                )
                              ],
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(17.5)),
                              color: Color.fromRGBO(
                                  227, 227, 227, 1.0)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text("Оформить заказ", style: style(16)),
                              ),

                            ],),
                    )

                    ),
                  ],),
                ),


              ]) //what you want to have inside, I suggest using a column
          );
        },
        context: ctx,
        //isDismissible:  //boolean if you want to be able to dismiss it
        //isScrollControlled: //boolean if something does not display, try that
    );

    //await DatabaseHelper.instance.addAccount('nik', 000);
    //int a = await DatabaseHelper.instance.getIdFromAccount('nik', 000);
    //print(a);
    //print(a);
  },
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
    _ContainerText(Donor.F_name, 45, 150),
    _ContainerText(Donor.L_name, 45, 150),
    _ContainerText(Donor.price_liter.toString(), 45, 100)
  ],));

Widget _ContainerInfo(dynamic txt0, dynamic txt, double height, double width){//контейнер для отдельного текста
  return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.only(top: 5, bottom: 10, right: 10, left: 10),
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.08),
          width: 1,),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.3803921568627451),
                offset: Offset(0.0, 2.5),
                blurRadius: 3,
                spreadRadius: 2
            )
          ],
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(17.5)),
          color: Color.fromRGBO(205, 205, 205, 1.0)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(txt0, style: style(16)),
          ),
          Text(txt, style: style(16)),

      ],),

  );
}


Widget _ContainerText(dynamic txt0, double height, double width){//контейнер для отдельного текста
  return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      height: height,
      width: width,
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.6313725490196078),
                offset: Offset(0.0, 1.0),
                blurRadius: 4,
                spreadRadius: 1
            )
          ],
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(12.5)),
          color: Color.fromRGBO(205, 205, 205, 1.0)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(txt0, style: style(16),),
        ],)

  );
}





TextStyle style (double sizef){
  return TextStyle(
      fontSize: sizef,
      color: Color.fromRGBO(0, 0, 0, 0.6509803921568628),

  );
}