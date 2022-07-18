import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class User extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get address => text().named('address')();
  IntColumn get occupation => integer().nullable()();
  TextColumn get date => text()();
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [User])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
  //GET ALL THE USERS FROM DB
  Future<List<UserData>> getUserList() async {
    return await select(user).get();
  }

  //INSERT NEW USER IN DB
  Future<int> insertUser(UserCompanion userCompanion) async {
    return await into(user).insert(userCompanion);
  }

  //DELETE FROM DATABASE
  Future<int> deleteUser(UserData userData) async {
    return await delete(user).delete(userData);
  }

  // UPDATE USERS
  Future<bool> updateUser(UserData userData) async {
    return await update(user).replace(userData);
  }
}
