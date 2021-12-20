// import 'package:flutter/material.dart';
// import 'app.dart';
//
// void main() {
//   const first = App();
//   runApp(const App());
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'dbhelper.dart';

int flag = 0;
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp (const App());
}

// class SqliteApp extends StatefulWidget {
//   const SqliteApp({Key? key}) : super(key: key);
//
//   @override
//  // _SqliteAppState createState() => _SqliteAppState();
// }

// class _SqliteAppState extends State<SqliteApp> {
//   int? selectedId;
//   final textController = TextEditingController();

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: TextField(
// //             controller: textController,
// //           ),
// //         ),
// //         body: Center(
// //           child: FutureBuilder<List<Donor>>(
// //               future: DatabaseHelper.instance.getName(),
// //               builder: (BuildContext context,
// //                   AsyncSnapshot<List<Donor>> snapshot) {
// //                 if (!snapshot.hasData) {
// //                   return Center(child: Text('Loading...'));
// //                 }
// //                 return snapshot.data!.isEmpty
// //                     ? Center(child: Text('No Groceries in List.'))
// //                     : ListView(
// //                   children: snapshot.data!.map((Donor) {
// //                     return Center(
// //                       child: Card(
// //                         shadowColor: Colors.black,
// //                         color: selectedId == Donor.id_donors
// //                             ? Colors.white70
// //                             : Colors.white,
// //                         child: ListTile(
// //                           title: Text(Donor.F_name),
// //                           onTap: () {
// //                             setState(() {
// //                               if (selectedId == null) {
// //                                 textController.text = Donor.F_name;
// //                                 selectedId = Donor.id_donors;
// //                               } else {
// //                                 textController.text = '';
// //                                 selectedId = null;
// //                               }
// //                             });
// //                           },
// //                           onLongPress: () {
// //                             setState(() {
// //                               DatabaseHelper.instance.remove(Donor.id_donors!);
// //                             });
// //                           },
// //                         ),
// //                       ),
// //                     );
// //                   }).toList(),
// //                 );
// //               }),
// //         ),
// //
// //         floatingActionButton: FloatingActionButton(
// //           child: Icon(Icons.save),
// //           onPressed: () async {
// //             //DatabaseHelper.instance.DropTable();
// //             //DatabaseHelper.instance.Test();
// //             //await DatabaseHelper.instance.createTable();
// //
// //             selectedId != null
// //                 ? await DatabaseHelper.instance.update(
// //               Donor(id_donors: selectedId, F_name: textController.text),
// //             )
// //               //  : await DatabaseHelper.instance.add(
// //               //Donor(F_name: textController.text),
// //             //);
// //             setState(() {
// //               textController.clear();
// //               selectedId = null;
// //             });
// //           },
// //         ),
// //
// //       ),
// //     );
// //   }
// // }
//
// class Donor {
//   final int? id_donors;
//   final String F_name;
//
//   Donor({this.id_donors, required this.F_name});
//
//   factory Donor.fromMap(Map<String, dynamic> json) {
//     return Donor(
//     id_donors: json['id_donors'],
//     F_name: json['F_name'],
//   );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id_donors': id_donors,
//       'F_name': F_name,
//     };
//   }
// }

