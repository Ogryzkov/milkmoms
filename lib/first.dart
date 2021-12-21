import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
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
      body:
      FutureBuilder<List<Donor>>(
          future: DatabaseHelper.instance.getInfoFromDonor(),
          builder: (BuildContext context,
              AsyncSnapshot<List<Donor>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text('Loading...'));
            }
            return snapshot.data!.isEmpty
                ? Center(child: Text('No Groceries in List.'))
                : ListView(
              children: snapshot.data!.map((Donor) {
                return Center(
                  child:
                      SizedBox(child: _buildLogin(Donor),
                      width: 400,)


                  // Card(
                  //   //shadowColor: Colors.black,
                  //   color: selectedId == Donor.id_donors
                  //       ? Colors.white70
                  //       : Colors.white,
                  //   child: ListTile(
                  //     title: Container(
                  //       color: Colors.red,
                  //       child: Text(Donor.F_name!),
                  //     ),
                  //     onTap: () {
                  //       setState(() {
                  //         if (selectedId == null) {
                  //           textController.text = Donor.F_name!;
                  //           selectedId = Donor.id_donors;
                  //         } else {
                  //           textController.text = '';
                  //           selectedId = null;
                  //         }
                  //       });
                  //     },
                  //     onLongPress: () {
                  //       setState(() {
                  //         DatabaseHelper.instance.deleteRaw(Donor.id_donors!);
                  //       });
                  //     },
                  //   ),
                  // ),
                );
              }).toList(),
            );
          }),


      

    );

  }
}


Widget _buildLogin(Donor Donor) => Container(
  alignment: Alignment.center,
  padding: const EdgeInsets.all(0),
  margin: const EdgeInsets.only(top: 10, bottom: 10),
  height: 100.0,
  decoration: const BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.47843137254901963),
          offset: Offset(0.0, 3.0),
          blurRadius: 8,
          spreadRadius: 3
        )
      ],
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(45)),
      color: Color.fromRGBO(205, 205, 205, 1.0)
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
    Text(Donor.L_name!,
      style: style(),),
    Text(Donor.F_name!, style: style(),),
    Text(Donor.Bday!, style: style())
  ],)

);


TextStyle style (){
  return const TextStyle(
      fontSize: 18,
      color: Color.fromRGBO(0, 0, 0, 0.6509803921568628),

  );
}