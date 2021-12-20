import 'dart:io';
import 'package:milkmoms/DbHelper.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'enter_screen.dart';
import 'main.dart';


class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'groceries.db');
    return await openDatabase(
      path,
      version: 1,
    );
  }


  void getInfo(dynamic login, dynamic password) async {
    Database db = await instance.database;
    //print(login);
    var Select = await db.rawQuery('SELECT * FROM Account WHERE Login="$login" and Password="$password"');
    //db.query("Account",columns: ["Login", "Password"], where: "Login = ?", whereArgs: [login]);
    if (Select.isNotEmpty) print('NotEmpty');
      else print('Empty');
    List<Account> Selects = Select.isNotEmpty
        ? Select.map((c) => Account.fromMap(c)).toList()
        : [];
    String Log = Selects.map((e) => e.id_account).toString();
    Log = Log.substring(1,Log.length-1);
    print(Log);
  }

  Future<void> DropTable(var tablename) async {
    Database db = await instance.database;
    await db.execute("DROP TABLE IF EXISTS $tablename");
  }

  Future<int> deleteRaw(int idAccount) async {
    Database db = await instance.database;
    return await db.delete('Account', where: 'id_account = ?', whereArgs: [idAccount]);
  }

  Future<int> add(dynamic name, dynamic password) async {
    Database db = await instance.database;
    var acc = {
      'Login': name,
      'Password': password
    };
    return await db.insert('Account', acc);
  }



  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Donor(
          id_donors INTEGER PRIMARY KEY,
          F_name VARCHAR,
          L_name VARCHAR,
          Bday DATE,
          Address VARCHAR,
          id_nation INTEGER,
          Score INTEGER,
          Requisites VARCHAR,
          Tel VARCHAR,
          id_Certificate INTEGER,
          Start_Certificate DATE,
          Finish_Certificate DATE
      )
      ''');
  }


  Future createTable() async {
    Database db = await instance.database;
    await db.execute('''
      CREATE TABLE Account(
          id_account INTEGER PRIMARY KEY AUTOINCREMENT,
          Login VARCHAR,
          Password VARCHAR
      )
      ''');
  }





  // Future Test() async {
  //   Database db = await instance.database;
  //   List<Map> result = await db.rawQuery('SELECT * FROM groceries WHERE name=?', ['два']);
  //   result.forEach((row) => print(row));
  // }

  // Future<List<Donor>> getName() async {
  //   Database db = await instance.database;
  //   var Donors = await db.query('Donor', orderBy: 'F_name');
  //   List<Donor> DonorList = Donors.isNotEmpty
  //       ? Donors.map((c) => Donor.fromMap(c)).toList()
  //       : [];
  //   return DonorList;
  // }


  // Future<List<Grocery>> getGroceries() async {
  //   Database db = await instance.database;
  //   var groceries = await db.query('groceries', orderBy: 'name');
  //   List<Grocery> groceryList = groceries.isNotEmpty
  //       ? groceries.map((c) => Grocery.fromMap(c)).toList()
  //       : [];
  //   return groceryList;
  // }





  //
  // Future<int> update(Donor donor) async {
  //   Database db = await instance.database;
  //   return await db.update('Donor', donor.toMap(),
  //       where: "id_donors = ?", whereArgs: [donor.id_donors]);
  // }


}

//
// F_name VARCHAR(30),
// L_name VARCHAR(30),
// Bday DATE,
//     Address VARCHAR(40),
// id_nation INT,
//     Score INT,
// Requisites VARCHAR(60),
// Tel VARCHAR(15),
// id_Certificate INT,
//     Start_Certificate DATE,
// Finish_Certificate DATE