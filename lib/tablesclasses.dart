import 'dart:ffi';

import 'dbhelper.dart';
import 'dart:io';

class Account {
  final int? id_account;
  final String Login;
  final String Password;

  Account({this.id_account, required this.Login, required this.Password});

  factory Account.fromMap(Map<String, dynamic> json) => Account(
      id_account: json['id_account'],
      Login: json['Login'],
      Password: json['Password']
  );

  Map<String, dynamic> toMap() {
    return {
      'id_account': id_account,
      'Login': Login,
      'Password': Password
    };
  }
}

class Registered {
  final int? id_registered;
  final int? State;
  final int? id_account;


  Registered({
    this.id_registered,
    this.State,
    this.id_account,
  });

  factory Registered.fromMap(Map<String, dynamic> json) => Registered(
      id_registered: json['id_registered'],
      State: json['State'],
      id_account: json['id_account']
  );

  Map<String, dynamic> toMap() {
    return {
      'id_registered': id_registered,
      'State': State,
      'id_account': id_account
    };}
}

class Donor {
  final int? id_donors;
  final String? F_name;
  final String? L_name;
  final String? Bday;
  final String? Street;
  final String? Apartment;
  final double? price_liter;
  final int? id_nation;
  final int? Score;
  final String? Requisites;
  final String? Tel;
  final int? id_Certificate;
  final String? Start_Certificate;
  final String? Finish_Certificate;

  Donor({
    this.id_donors,
    this.F_name,
    this.L_name,
    this.Bday,
    this.Street,
    this.Apartment,
    this.price_liter,
    this.id_nation,
    this.Score,
    this.Requisites,
    this.Tel,
    this.id_Certificate,
    this.Start_Certificate,
    this.Finish_Certificate,});

  factory Donor.fromMap(Map<String, dynamic> json) => Donor(
      id_donors: json['id_donors'],
      F_name: json['F_name'],
      L_name: json['L_name'],
      Bday: json['Bday'],
      Street: json['Street'],
      Apartment: json['Apartment'],
      price_liter: json['price_liter'],
      id_nation: json['id_nation'],
      Score: json['Score'],
      Requisites: json['Requisites'],
      Tel: json['Tel'],
      id_Certificate: json['id_Certificate'],
      Start_Certificate: json['Start_Certificate'],
      Finish_Certificate: json['Finish_Certificate']
  );

  Map<String, dynamic> toMap() {
    return {
      'id_donors': id_donors,
      'F_name': F_name,
      'L_name': L_name,
      'Bday': Bday,
      'Street': Street,
      'Apartment': Apartment,
      'price_liter': price_liter,
      'id_nation': id_nation,
      'Score': Score,
      'Requisites': Requisites,
      'Tel': Tel,
      'id_Certificate': id_Certificate,
      'Start_Certificate': Start_Certificate,
      'Finish_Certificate': Finish_Certificate
    };
  }
}

class Nations {
  final int? id_nation;
  final String Nation_name;

  Nations({this.id_nation, required this.Nation_name});

  factory Nations.fromMap(Map<String, dynamic> json) =>
      Nations(
          id_nation: json['id_nation'],
          Nation_name: json['Nation_name']
      );

  Map<String, dynamic> toMap() {
    return {
      'id_nation': id_nation,
      'Nation_name': Nation_name
    };
  }
}


class Customer {
  final int? id_customer;
  final int? id_account;
  final String? F_name;
  final String? L_name;
  final String? Street;
  final String? Apartment;
  final String? Requisites;
  final String? Tel;

  Customer({
    this.id_customer,
    this.id_account,
    this.F_name,
    this.L_name,
    this.Street,
    this.Apartment,
    this.Requisites,
    this.Tel,
  });

  factory Customer.fromMap(Map<String, dynamic> json) => Customer(
      id_customer: json['id_customer'],
      id_account: json['id_account'],
      F_name: json['F_name'],
      L_name: json['L_name'],
      Street: json['Street'],
      Apartment: json['Apartment'],
      Requisites: json['Requisites'],
      Tel: json['Tel']
  );

  Map<String, dynamic> toMap() {
    return {
      'id_customer': id_customer,
      'id_account': id_account,
      'F_name': F_name,
      'L_name': L_name,
      'Street': Street,
      'Apartment': Apartment,
      'Requisites': Requisites,
      'Tel': Tel,
    };}
}



class Driver {
  final int? id_driver;
  final String F_name;
  final String L_name;
  final String Tel;
  final DateTime BD;
  final bool Sex;

  Driver({
    this.id_driver,
    required this.F_name,
    required this.L_name,
    required this.Tel,
    required this.BD,
    required this.Sex,});

  factory Driver.fromMap(Map<String, dynamic> json) =>
      Driver(
        id_driver: json['id_driver'],
        F_name: json['F_name'],
        L_name: json['L_name'],
        Tel: json['Tel'],
        BD: json['BD'],
        Sex: json['Sex'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id_driver': id_driver,
      'F_name': F_name,
      'L_name': L_name,
      'Tel': Tel,
      'BD': BD,
      'Sex': Sex
    };
  }
}


class Shipping_car {
  final int? id_shipping_car;
  final String Car_number;
  final String Car_color;
  final String Car_model;

  Shipping_car({
    this.id_shipping_car,
    required this.Car_number,
    required this.Car_color,
    required this.Car_model,});

  factory Shipping_car.fromMap(Map<String, dynamic> json) =>
      Shipping_car(
        id_shipping_car: json['id_shipping_car'],
        Car_number: json['Car_number'],
        Car_color: json['Car_color'],
        Car_model: json['Car_model'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id_shipping_car': id_shipping_car,
      'Car_number': Car_number,
      'Car_color': Car_color,
      'Car_model': Car_model
    };
  }
}


class Ship {
  final int? id_ship;
  final int id_Shipping_car;
  final int id_driver;


  Ship({
    this.id_ship,
    required this.id_Shipping_car,
    required this.id_driver});

  factory Ship.fromMap(Map<String, dynamic> json) =>
      Ship(
        id_ship: json['id_ship'],
        id_Shipping_car: json['id_Shipping_car'],
        id_driver: json['id_driver'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id_ship': id_ship,
      'id_Shipping_car': id_Shipping_car,
      'id_driver': id_driver
    };
  }
}


class Orders {
  final int? id_order;
  final int id_donors;
  final int id_registered;
  final int id_account;
  final int id_ship;
  final String start_order;
  final String finish_order;
  final int score_order;
  final double liter_value;
  final double price_ful;
  final String status;



  Orders({
    this.id_order,
    required this.id_donors,
    required this.id_registered,
    required this.id_account,
    required this.id_ship,
    required this.start_order,
    required this.finish_order,
    required this.score_order,
    required this.liter_value,
    required this.price_ful,
    required this.status,
  });

  factory Orders.fromMap(Map<String, dynamic> json) =>
      Orders(
          id_order: json['id_order'],
          id_donors: json['id_donors'],
          id_registered: json['id_registered'],
          id_account: json['id_account'],
          id_ship: json['id_ship'],
          start_order: json['start_order'],
          finish_order: json['finish_order'],
          score_order: json['score_order'],
          liter_value: json['liter_value'],
          price_ful: json['price_ful'],
          status: json['status']
      );

  Map<String, dynamic> toMap() {
    return {
      'id_order': id_order,
      'id_donors': id_donors,
      'id_registered': id_registered,
      'id_account': id_account,
      'id_ship': id_ship,
      'start_order': start_order,
      'finish_order': finish_order,
      'score_order': score_order,
      'liter_value': liter_value,
      'price_ful': price_ful,
      'status': status,
    };
  }
}
