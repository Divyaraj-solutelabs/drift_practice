import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:users_detail/database/database.dart';
import 'package:users_detail/screen/user_list_page.dart';
import 'package:users_detail/services/operation.dart';
import 'package:users_detail/util/occupation_picker.dart';
import 'package:provider/provider.dart';

class UserDetailPage extends StatefulWidget {
  final String title;
  final UserCompanion userCompanion;
  const UserDetailPage(
      {Key? key, required this.title, required this.userCompanion})
      : super(key: key);

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  late AppDatabase appDatabase;
  late TextEditingController nameEditingController;
  late TextEditingController addressEditingController;
  int occupation = 0;

  @override
  void initState() {
    nameEditingController = TextEditingController();
    addressEditingController = TextEditingController();
    nameEditingController.text = widget.userCompanion.name.value;
    addressEditingController.text = widget.userCompanion.address.value;
    occupation = widget.userCompanion.occupation.value!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    appDatabase = Provider.of<AppDatabase>(context);
    return Scaffold(
     // backgroundColor: colors[colorLevel],
      appBar: _getDetailAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            OccupationPicker(
              index: occupation,
              onTap: (selectedIndex) {
                occupation = selectedIndex;
              },
            ),
            const SizedBox(
              height: 10,
            ),

            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: nameEditingController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintText: 'Enter Name'),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: addressEditingController,
              maxLength: 105,
              minLines: 4,
              maxLines: 5,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintText: 'Enter Address'),
            ),
          ],
        ),
      ),
    );
  }

  _getDetailAppBar() {
    return AppBar(
     backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.chevron_left_outlined,
          color: Colors.black,
        ),
      ),
      title: Text(
        widget.title,
        style: const TextStyle(color: Colors.black),
      ),
      actions: [
        IconButton(
          onPressed: () {
           // _saveToDb();
            if(widget.userCompanion.id.present){
              operations().upadte(nameEditingController.text, addressEditingController.text, occupation, widget.userCompanion.id.value,appDatabase);
              Navigator.pop(context, true);
            }
            else{
              operations().insert(nameEditingController.text, addressEditingController.text, occupation,appDatabase);
              Navigator.pop(context, true);
            }
          },
          icon: const Icon(
            Icons.save,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: () {
            _deleteNotes();
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.black,
          ),
        ),
      ],
    );
  }



  void _deleteNotes() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete User?'),
          content: Text('Do you really want to delete this user'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                appDatabase
                    .deleteUser(UserData(
                        id: widget.userCompanion.id.value,
                        name: widget.userCompanion.name.value,
                        address: widget.userCompanion.address.value,
                        date: DateFormat.yMMMd().format(DateTime.now())))
                    .then((value) {
                  Navigator.pop(context, true);
                });

              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
