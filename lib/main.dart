import 'package:flutter/material.dart';
import 'package:users_detail/database/database.dart';
import 'package:users_detail/screen/user_list_page.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AppDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          textTheme: const TextTheme(
            headline5: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 24),
            bodyText2: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20),
            bodyText1: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontSize: 18),
            subtitle2: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontSize: 14),
          ),
        ),
        home: const UserListPage(),
      ),
    );
  }
}
