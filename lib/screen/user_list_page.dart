import 'package:drift/drift.dart' as dr;
import 'package:flutter/material.dart';
import 'package:users_detail/database/database.dart';
import 'package:users_detail/screen/user_detail_page.dart';
import 'package:provider/provider.dart';
import 'package:users_detail/services/operation.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);
  static String route_name = '/userList';
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late AppDatabase database;

  @override
  Widget build(BuildContext context) {
    database = Provider.of<AppDatabase>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Users',
          style: Theme.of(context).textTheme.headline5,
        ),

      ),
      body: FutureBuilder<List<UserData>>(
        future: _getUserFromDatabase(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<UserData>? userList = snapshot.data;
            if (userList != null) {
              if (userList.isEmpty) {
                return Center(
                  child: Text(
                    'No Users Found, Click on add button to add new user',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                );
              } else {
                return userListUI(userList);
              }
            }
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              snapshot.error.toString(),
              style: Theme.of(context).textTheme.bodyText2,
            ));
          }
          return Center(
            child: Text(
              'Click on add button to add new note',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToDetail(
              'Add User',
              const UserCompanion(
                  name: dr.Value(''),
                  address: dr.Value(''),
                  occupation: dr.Value(0)));
        },
        shape: const CircleBorder(
          side: BorderSide(color: Colors.black, width: 2),
        ),
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }

  Future<List<UserData>> _getUserFromDatabase() async {
    return await database.getUserList();
  }

  Widget userListUI(List<UserData> userList) {
    return ListView.builder(
      itemCount: userList.length,
      //padding: EdgeInsets.only(left: 5,right: 5,top: 15,bottom: 15),
      //crossAxisCount: 4,
      itemBuilder: (context, index) {
        UserData userData = userList[index];
        return InkWell(
          onTap: () {
            _navigateToDetail(
              'Edit User',
              UserCompanion(
                  id: dr.Value(userData.id),
                  name: dr.Value(userData.name),
                  address: dr.Value(userData.address),
                  occupation: dr.Value(userData.occupation),
                  ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black),
             //   color: colors[noteData.color!]
         ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        userData.name,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    Text(
                      operations().getPriority(userData.occupation!),
                      //_getPriority(userData.occupation!),
                      style: TextStyle(color: operations().getColor(userData.occupation!)),
                    )
                  ],
                ),
                Text(
                  userData.address,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      userData.date,
                      style: Theme.of(context).textTheme.subtitle2,
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },

    );
  }

  _navigateToDetail(String title, UserCompanion userCompanion) async {
    var res = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserDetailPage(
          title: title,
          userCompanion: userCompanion,
        ),
      ),
    );
    if (res != null && res == true) {
      setState(() {});
    }
  }






}
