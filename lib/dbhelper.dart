import 'dart:io';
import 'package:milkmoms/tablesclasses.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'main.dart';


class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'MMos.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate
    );
  }




Future<int> getInfo(dynamic login, dynamic password) async {
    Database db = await instance.database;
    var Select = await db.rawQuery('SELECT * FROM Account WHERE Login="$login" and Password="$password"');
    if (Select.isNotEmpty) print('NotEmpty');
      else print('Empty');
    List<Account> Selects = Select.isNotEmpty
        ? Select.map((c) => Account.fromMap(c)).toList()
        : [];
    String Log = Selects.map((e) => e.id_account).toString();
    Log = Log.substring(1,Log.length-1);
    int id = int.parse(Log);
    return id;
  }

void getInfoCustomer(dynamic id) async {
    Database db = await instance.database;
    var Select = await db.rawQuery('SELECT * FROM Customer WHERE id_account="$id"');
    if (Select.isNotEmpty) print('NotEmpty');
    else print('Empty');
    List<Customer> Selects = Select.isNotEmpty
        ? Select.map((c) => Customer.fromMap(c)).toList()
        : [];
    String Log = Selects.map((e) => e.L_name).toString();
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

  Future<int> addAccount(dynamic Login, dynamic Password) async {
    Database db = await instance.database;
    var acc = {
      'Login': Login,
      'Password': Password,
    };
    return await db.insert('Account', acc);
  }

  Future<int> addCustomer(int id_account, dynamic F_name, dynamic L_name, dynamic Street, dynamic Apartment, dynamic Requisites, dynamic Tel) async {
    Database db = await instance.database;
    var acc = {
      'id_account': id_account,
      'F_name': F_name,
      'L_name': L_name,
      'Street': Street,
      'Apartment': Apartment,
      'Requisites': Requisites,
      'Tel': Tel,
    };
    return await db.insert('Customer', acc);
  }



  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Account(
          id_account INTEGER PRIMARY KEY AUTOINCREMENT,
          Login VARCHAR,
          Password VARCHAR
      )
      ''');//account
    await db.execute('''
      CREATE TABLE Nations
          (
          id_nation INTEGER PRIMARY KEY AUTOINCREMENT,
          Nation_name VARCHAR
          )
      ''');//nations
    await db.execute('''
      CREATE TABLE Donor(
          id_donors INTEGER PRIMARY KEY AUTOINCREMENT,
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
      ''');//donor
    await db.execute('''
      CREATE TABLE Customer
          (
          id_customer INTEGER PRIMARY KEY AUTOINCREMENT,
          id_account INT,
          F_name VARCHAR,
          L_name VARCHAR,
          Street VARCHAR,
          Apartment VARCHAR,
          Requisites VARCHAR,
          Tel VARCHAR,
          CONSTRAINT Account_rout FOREIGN KEY (id_account) REFERENCES Account (id_account)
          )
      ''');//customer
    await db.execute('''
      CREATE TABLE Driver
          (
          id_driver INTEGER PRIMARY KEY AUTOINCREMENT,
          F_name VARCHAR,
          L_name VARCHAR,
          Tel VARCHAR,
          BD DATE,
          Sex VARCHAR
          )
      ''');//Driver
    await db.execute('''
      CREATE TABLE Shipping_car
          (
          id_shipping_car INTEGER PRIMARY KEY AUTOINCREMENT,
          Car_number VARCHAR,
          Car_color VARCHAR,
          Car_model VARCHAR
          )
      ''');//Shipping_car
    await db.execute('''
      CREATE TABLE Ship
          (
          id_ship INTEGER PRIMARY KEY AUTOINCREMENT,
          id_Shipping_car INT,
          id_driver INT,
          CONSTRAINT Car_rout FOREIGN KEY (id_shipping_car) REFERENCES Shipping_car (id_shipping_car),
          CONSTRAINT Driver_rout FOREIGN KEY (id_driver) REFERENCES Driver (id_driver)
          )
      ''');//Ship
    await db.execute('''
      CREATE TABLE Orders
          (
          id_order INTEGER PRIMARY KEY AUTOINCREMENT,
          id_donors INT,
          id_customer INT,
          id_ship INT,
          start_order datetime,
          finish_order datetime,
          score_order INT,
          liter_value FLOAT,
          price_liter FLOAT,
          price_ful FLOAT,
          status VARCHAR,
          CONSTRAINT Donors_rout FOREIGN KEY (id_donors) REFERENCES Donors (id_donors),
          CONSTRAINT Customer_rout FOREIGN KEY (id_customer) REFERENCES Customer (id_customer),
          CONSTRAINT Ship_rout FOREIGN KEY (id_ship) REFERENCES Ship (id_ship)
          )
      ''');//Orders
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