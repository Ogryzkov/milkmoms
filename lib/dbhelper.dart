import 'dart:io';
import 'package:milkmoms/tablesclasses.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'main.dart';
import 'globals.dart' as globals;
import 'package:intl/intl.dart';

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
          Street VARCHAR,
          Apartment VARCHAR,
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
    await db.execute('''
      CREATE TABLE Registered(
          id_registered INTEGER PRIMARY KEY,
          State INT,
          id_account INT
      )
      ''');
  }

  Future<int> addAccount(dynamic Login, dynamic Password) async {
    Database db = await instance.database;
    var acc = {
      'Login': Login,
      'Password': Password,
    };
    return await db.insert('Account', acc);
  }// НЕ УДАЛЯТЬ. СОЗДАНИЕ АККАУНТА



  Future<int> getIdFromAccount(dynamic login, dynamic password) async {
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

  Future<int> addDonor(
      dynamic F_name,
      dynamic L_name,
      dynamic Bday,
      dynamic Street,
      dynamic Apartment,
      dynamic id_nation,
      dynamic Score,
      dynamic Requisites,
      dynamic Tel,
      dynamic id_Certificate,
      dynamic Start_Certificate,
      dynamic Finish_Certificate) async {
    Database db = await instance.database;
    var acc = {
      'F_name': F_name,
      'L_name': L_name,
      'Bday': Bday,
      'Street': Street,
      'Apartment': Apartment,
      'id_nation': id_nation,
      'Score': Score,
      'Requisites': Requisites,
      'Tel': Tel,
      'id_Certificate': id_Certificate,
      'Start_Certificate': Start_Certificate,
      'Finish_Certificate': Finish_Certificate,
    };
    return await db.insert('Donor', acc);
  }



   void addNation() async {
    Database db = await instance.database;
    //return await db.insert('Nations', acc);
    await db.rawInsert(' INSERT INTO Nations (Nation_name) VALUES ("Русские"), ("Татары"),("Украинцы"),("Башкиры"), ("Чеченцы"),("Армяне"),("Мордва"),("Казахи"),("Азербайджанцы")');
  }//ИНСЕРТИТ НАЗВАНИЯ НАЦИОНАЛЬНОСТЕЙ, АВТОИНКРЕМЕНТ

  // void getInfoFromDonor(int id_donors) async {
  //   Database db = await instance.database;
  //   var Select = await db.rawQuery('SELECT * FROM Donor WHERE id_donors="$id_donors"');
  //   if (Select.isNotEmpty) print('NotEmpty');
  //   else print('Empty');
  //   List<Donor> Selects = Select.isNotEmpty
  //       ? Select.map((c) => Donor.fromMap(c)).toList()
  //       : [];
  //
  //   var Element = Selects.map((e) {e.Bday.toString();
  //   });
  //
  //   print(Element);
  //
  //   //return Element.elementAt(0);
  // }//возвращает стринг элемент из донора




  void getInfoCustomer(dynamic id) async {
    Database db = await instance.database;
    var Select = await db.rawQuery('SELECT L_name, F_name FROM Customer');
    if (Select.isNotEmpty) print('NotEmpty');
    else print('Empty');
    List<Customer> Selects = Select.isNotEmpty
        ? Select.map((c) => Customer.fromMap(c)).toList()
        : [];
    var Log = Selects.map((e) {
      return e.L_name;
    });
    var info = Selects.map((e) {
      return [e.L_name, e.F_name].toList();
    });

    print(info.elementAt(1));
    //Log = Log.substring(1,Log.length-1);
    //print(Log.runtimeType);
    // print(Selects.map((e) {
    //   return [e.L_name, e.F_name].toString();
    // }));
  }

  Future<void> DropTable(var tablename) async {
    Database db = await instance.database;
    await db.execute("DROP TABLE IF EXISTS $tablename");
  }//Удаляет таблицу если она существует

  Future<int> deleteRaw(int id_donors) async {
    Database db = await instance.database;
    return await db.delete('Donor', where: 'id_donors = ?', whereArgs: [id_donors]);
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

  Future<int> addDonors(int id_account, dynamic F_name, dynamic L_name, dynamic Street, dynamic Apartment, dynamic Requisites, dynamic Tel) async {
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




  Future<int> AddRegistered() async {
    Database db = await instance.database;
    var acc = {
      'id_registered': 1,
      'State': 0,
      'id_account': 0
    };
    return await db.insert('Registered', acc);
  }

  Future<int> RegisteredState() async {
    Database db = await instance.database;
    var Select = await db.rawQuery('SELECT State FROM Registered WHERE id_registered="1"');
    if (Select.isNotEmpty) print('NotEmpty');
    else print('Empty');
    List<Registered> Selects = Select.isNotEmpty
        ? Select.map((c) => Registered.fromMap(c)).toList()
        : [];
    var info = Selects.map((e) {
      return e.State!.toInt();
    });
    return info.elementAt(0);
  }//возвращает, значение state

  Future<int> RegisteredIdAccount() async {
    Database db = await instance.database;
    var Select = await db.rawQuery('SELECT id_account FROM Registered WHERE id_registered=1');
    if (Select.isNotEmpty) print('NotEmpty');
    else print('Empty');
    List<Registered> Selects = Select.isNotEmpty
        ? Select.map((c) => Registered.fromMap(c)).toList()
        : [];
    var info = Selects.map((e) {
      return e.id_account!.toInt();
    });
    return info.elementAt(0);
  }//возвращает, значение state

  void setRegistered(int State, int id_account) async {
      Database db = await instance.database;
      int a = 1;
      int b = await db.rawUpdate('UPDATE Registered SET State = ?, id_account = ? WHERE id_registered = ?',
        [State, id_account, a]);
      print(b);
    }//устанавливает регистрацию по ключаем State, id_account

  void getInfoRegistered() async {
    Database db = await instance.database;
    int a = 1;
    var Select = await db.rawQuery('SELECT * FROM Registered WHERE id_registered = $a');
    if (Select.isNotEmpty) print('NotEmpty');
    else print('Empty');
    List<Registered> Selects = Select.isNotEmpty
        ? Select.map((c) => Registered.fromMap(c)).toList()
        : [];
    // String Log = Selects.map((e) => e.id_account).toString();
    // Log = Log.substring(1,Log.length-1);
    // int id = int.parse(Log);
    // print(id);
    var info = Selects.map((e) {
      return [e.id_account, e.State].toList();
    });
    print (info);

  }//возвращает пару id_account, state

  Future createTable() async {
    Database db = await instance.database;
    await db.execute('''
          CREATE TABLE Donor(
          id_donors INTEGER PRIMARY KEY AUTOINCREMENT,
          F_name VARCHAR,
          L_name VARCHAR,
          Bday VARCHAR,
          Street VARCHAR,
          Apartment VARCHAR,
          id_nation INTEGER,
          Score INTEGER,
          Requisites VARCHAR,
          Tel VARCHAR,
          id_Certificate INTEGER,
          Start_Certificate VARCHAR,
          Finish_Certificate VARCHAR
      )
      ''');
  }


  Future<int> getCount(String tableName) async {
    Database db = await instance.database;
    var Select = await db.rawQuery('SELECT count(*) from $tableName');
    int count = Sqflite.firstIntValue(Select)!;
    return count;
  }




  Future<List<Donor>> getInfoFromDonor() async {
    Database db = await instance.database;
    var Select = await db.rawQuery('SELECT * FROM Donor');
    if (Select.isNotEmpty) print('NotEmpty');
    else print('Empty');
    List<Donor> result = Select.isNotEmpty
        ? Select.map((c) => Donor.fromMap(c)).toList()
        : [];
    return result;
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