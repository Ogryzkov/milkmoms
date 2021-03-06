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
      onCreate: _onCreate,
      onConfigure: _onConfigure
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
          Bday VARCHAR,
          Street VARCHAR,
          Apartment VARCHAR,
          price_liter FLOAT,
          id_nation INTEGER,
          Score INTEGER,
          Requisites VARCHAR,
          Tel VARCHAR,
          id_Certificate INTEGER,
          Start_Certificate VARCHAR,
          Finish_Certificate VARCHAR
      )
      ''');//donor
    await db.rawInsert('INSERT INTO Donor (F_name, L_name, Bday, Street, Apartment, price_liter, id_nation, Score, Requisites, Tel, id_Certificate, Start_Certificate, Finish_Certificate) VALUES ("Виктория","Петрова","1985-05-21","Луговая", "5", 200, 1, 4, "5121649166602513","7968589626", 96612, "2021-06-22", "2022-06-22"), ("Анжелика","Иванова","1983-01-02","Оренбургская", "12", 250, 1, 4, "5369909261118893","7913952237", 11542, "2021-03-22", "2022-03-22"), ("Елизавета","Зарица","1993-02-18","Советская", "61", 300, 7, 5, "5121649010216999","7906261451", 16482, "2021-09-19", "2022-09-19"), ("Марьямна","Кугушева","1988-05-05","Пушкинская", "121", 200, 2, 3, "5323570151567303","7975956572", 12516, "2021-01-05", "2022-01-05"), ("Римма","Койначёнока","1992-08-19","Уральская", "13", 250, 1, 5, "5404370884368695","7927845561", 19548, "2021-08-09", "2022-08-09"), ("Александра","Саблина","1990-05-16","Тютчева", "85", 280, 4, 2, "5324207882403081","7990517003", 56848, "2021-02-01", "2022-02-01"), ("Ева","Базина","1994-01-10","Угольная", "4", 320, 7, 1, "5315785609657320","7961943728", 13068, "2021-02-05", "2022-02-05"), ("Любовь","Невская","1990-05-19","Кривая", "18", 350, 3, 5, "5315770813644132","7936494363", 51357, "2021-03-06", "2022-03-06"), ("Людмила","Кубышкина","1984-12-13","Володская", "103", 400, 1, 5, "5324203222639401","7965040736", 51568, "2021-05-09", "2022-05-09"), ("Альбина","Ярная","1992-02-21","Нижняя", "89", 250, 2, 3, "5127173678805849","7943927566", 46258, "2021-08-08", "2022-08-08")');
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
          CONSTRAINT Account_routs FOREIGN KEY (id_account) REFERENCES Account (id_account)
          )
      ''');//customer
    await db.execute('''
      CREATE TABLE Driver
          (
          id_driver INTEGER PRIMARY KEY AUTOINCREMENT,
          F_name VARCHAR,
          L_name VARCHAR,
          Tel VARCHAR,
          BD VARCHAR,
          Sex VARCHAR
          )
      ''');//Driver
    await db.rawInsert('INSERT INTO Driver (F_name, L_name, Tel, BD, Sex) VALUES ("Семен","Ишутин","7958955306","1992-09-06","мужской"), ("Роман","Орлов","7974297133","1971-09-28","мужской"),("Евгений","Вавилов","7931180637","1982-10-11","мужской"),("Яков","Пахомов","7974514199","1984-06-15","мужской"),("Георгий","Карибжанов","7982309739","1979-08-21","мужской"),("Федот","Меншиков","7952976195","1994-02-02","мужской"),("Савва","Чирков","7958956120","1991-01-08","мужской")');
    await db.execute('''
      CREATE TABLE Shipping_car
          (
          id_shipping_car INTEGER PRIMARY KEY AUTOINCREMENT,
          Car_number VARCHAR,
          Car_color VARCHAR,
          Car_model VARCHAR
          )
      ''');//Shipping_car
    await db.rawInsert(' INSERT INTO Shipping_car (Car_number, Car_color, Car_model) VALUES ("Н536УР","Серый","Ford minivan"), ("В967ЕО","Белый","Ford minivan"), ("К585ХУ","Серый","Ford minivan"), ("В061МК","Белый","Ford minivan"), ("Х380АУ","Черный","Ford minivan")');
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
    await db.rawInsert('INSERT INTO Ship (id_Shipping_car, id_driver) VALUES (2,2),(3,3),(4,4),(5,5),(1,3),(1,5),(2,4),(2,3)');
    await db.execute('''
      CREATE TABLE Registered(
          id_registered INTEGER PRIMARY KEY,
          State INT,
          id_account INT
      )
      ''');
    await db.execute('''
      CREATE TABLE Orders
          (
          id_order INTEGER PRIMARY KEY AUTOINCREMENT,
          id_donors INT,
          id_registered INT,
          id_account INT,
          id_ship INT,
          start_order VARCHAR,
          finish_order VARCHAR,
          score_order INT,
          liter_value FLOAT,
          price_ful FLOAT,
          status VARCHAR,
          CONSTRAINT Donors_rout FOREIGN KEY (id_donors) REFERENCES Donor (id_donors),
          CONSTRAINT Registered_rout FOREIGN KEY (id_registered) REFERENCES Registered (id_registered),
          CONSTRAINT Ship_rout FOREIGN KEY (id_ship) REFERENCES Ship (id_ship)
          )
      ''');//Orders

  }
  //CONSTRAINT Account_rout FOREIGN KEY (id_account) REFERENCES Registered (id_account),
  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }//Конфигурация БД

  void transaction(dynamic id_donors, dynamic id_ship, dynamic start_order, dynamic finish_order, dynamic liter_value, dynamic price_ful, dynamic status) async{
    Database db = await instance.database;
    try {
      await db.transaction((txn) async {
        addOrder(id_donors, id_ship, start_order, finish_order, liter_value, price_ful, status);
      });
    } catch (e) {
    print ('SQL Исключение: $e ');
    }
  }//транзакция


  Future<int> addOrder(dynamic id_donors, dynamic id_ship, dynamic start_order, dynamic finish_order, dynamic liter_value, dynamic price_ful, dynamic status) async {
    Database db = await instance.database;
    int A = await RegisteredIdAccount();
    print(A);
    var acc = {
      'id_donors': id_donors,
      'id_registered': 1,
      'id_account': A,
      'id_ship': id_ship,
      'start_order': start_order,
      'finish_order': finish_order,
      'score_order': 4,
      'liter_value': liter_value,
      'price_ful': price_ful,
      'status': status
    };
    return await db.insert('Orders', acc);
  }// НЕ УДАЛЯТЬ. СОЗДАНИЕ ЗАКАЗА

  Future<List<Orders>> getInfoFromOrder() async {
    Database db = await instance.database;
    var Select = await db.rawQuery('SELECT * FROM Orders JOIN Registered ON Orders.id_registered=Registered.id_registered WHERE Orders.id_account=Registered.id_account');
    if (Select.isNotEmpty) print('NotEmpty');
    else print('Empty');
    List<Orders> result = Select.isNotEmpty
        ? Select.map((c) => Orders.fromMap(c)).toList()
        : [];
    return result;
  }

  Future<int> addShip(dynamic Login, dynamic Password) async {
    Database db = await instance.database;
    var acc = {
      'Login': Login,
      'Password': Password,
    };
    return await db.insert('Account', acc);
  }// НЕ УДАЛЯТЬ. СОЗДАНИЕ АККАУНТА

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
      dynamic price_liter,
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
  }//возвращает id_account

  void setRegistered(int State, int id_account) async {
      Database db = await instance.database;
      int a = 1;
      int b = await db.rawUpdate('UPDATE Registered SET State = ?, id_account = ? WHERE id_registered = ?',
        [State, id_account, a]);
      print(b);
    }//устанавливает регистрацию по ключаем State, id_account

  void UpdateCustomer(name, surname, street, aps, requits, tel, id_account) async {
    Database db = await instance.database;
    int b = await db.rawUpdate('UPDATE Customer SET F_name = ?, L_name = ?, Street = ?, Apartment = ?, Requisites = ?, Tel = ? WHERE id_account = ?',
        [name, surname, street, aps, requits, tel, id_account]);
    print(b);
  }//апдейтит поля пользователя по айди аккаунта

  void UpdateProgress(dynamic id_order, dynamic text) async {
    Database db = await instance.database;
    int b = await db.rawUpdate('UPDATE Orders SET status = ? WHERE id_order = ?',
        [text ,id_order]);
    print(b);
  }//апдейтит поля пользователя по айди аккаунта

  // Future<List<int?>> getInfoRegistered() async {
  //   Database db = await instance.database;
  //   int a = 1;
  //   var Select = await db.rawQuery('SELECT * FROM Registered WHERE id_registered = $a');
  //   if (Select.isNotEmpty) print('NotEmpty');
  //   else print('Empty');
  //   List<Registered> Selects = Select.isNotEmpty
  //       ? Select.map((c) => Registered.fromMap(c)).toList()
  //       : [];
  //   // String Log = Selects.map((e) => e.id_account).toString();
  //   // Log = Log.substring(1,Log.length-1);
  //   // int id = int.parse(Log);
  //   // print(id);
  //
  //
  //   //print (info);
  //
  // }//возвращает пару id_account, state

  Future<List<Registered>> getInfoFromRegistered() async {
    Database db = await instance.database;
    int a = 1;
    var Select = await db.rawQuery('SELECT * FROM Registered WHERE id_registered = $a');
    if (Select.isNotEmpty) print('NotEmpty');
    else print('Empty');
    List<Registered> Selects = Select.isNotEmpty
        ? Select.map((c) => Registered.fromMap(c)).toList()
        : [];
    return Selects;
  }


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

  Future<List<Customer>> getInfoFromCustomer() async {
    Database db = await instance.database;
    var Select = await db.rawQuery('SELECT * FROM Customer');
    if (Select.isNotEmpty) print('NotEmpty');
    else print('Empty');
    List<Customer> result = Select.isNotEmpty
        ? Select.map((c) => Customer.fromMap(c)).toList()
        : [];
    return result;
  }

  Future<List<Customer>> getInfoFromOneCustomer(int id_customer) async {
    Database db = await instance.database;
    var Select = await db.rawQuery('SELECT * FROM Customer WHERE id_customer="$id_customer"');
    if (Select.isNotEmpty) print('NotEmpty');
    else print('Empty');
    List<Customer> result = Select.isNotEmpty
        ? Select.map((c) => Customer.fromMap(c)).toList()
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