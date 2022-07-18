import 'package:drift/drift.dart' as dr;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:users_detail/database/database.dart';
import 'package:users_detail/util/occupation_picker.dart';
import 'package:provider/provider.dart';


class operations{
  late AppDatabase appDatabase1;
  //= Provider.of<AppDatabase>(listen: false);

  void insert(String name, String address, int occ,AppDatabase appDatabase ){
    appDatabase1=appDatabase;
    appDatabase1
        .insertUser(UserCompanion(
        name: dr.Value(name),
        address: dr.Value(address),
        occupation: dr.Value(occ),
        date: dr.Value(DateFormat.yMMMd().format(DateTime.now()))))
        .then((value) {
      // Navigator.pop(context, true);
    });
  }
  void upadte(String name, String address, int occ,int id,AppDatabase appDatabase){
    appDatabase1=appDatabase;
    appDatabase1
        .updateUser(UserData(
        id: id,
        name: name,
        address: address,
        occupation: occ,
        date: DateFormat.yMMMd().format(DateTime.now())))
        .then((value) {
      // Navigator.pop(context, true);
    });
  }

  void delete(String name, String address, int occ,int id,AppDatabase appDatabase){
    appDatabase1=appDatabase;
    appDatabase1
        .deleteUser(UserData(
        id: id,
        name: name,
        address: address,
        date: DateFormat.yMMMd().format(DateTime.now())));
  }

  String getPriority(int p) {
    switch (p) {
      case 2:
        return 'Unemployed';
      case 1:
        return 'Professional';
      default:
        return 'Student';
    }
  }

  getColor(int priority) {
    switch (priority) {
      case 2:
        return Colors.red;
      case 1:
        return Colors.green;
      default:
        return Colors.greenAccent;
    }
  }



}
