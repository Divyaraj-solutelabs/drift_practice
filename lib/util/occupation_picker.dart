import 'package:flutter/material.dart';

class OccupationPicker extends StatefulWidget {
  int index;
  Function(int) onTap;
  OccupationPicker({Key? key, required this.index, required this.onTap})
      : super(key: key);

  @override
  _OccupationPickerState createState() => _OccupationPickerState();
}

class _OccupationPickerState extends State<OccupationPicker> {
  List<String> nameList = ['Student', 'Professional', 'Unemployed'];
  List<Color> colorList = [Colors.greenAccent,Colors.green , Colors.red];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: nameList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              widget.index = index;
              widget.onTap(index);
              setState(() {});
            },
            child: Container(
              margin: EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black),
                  color:
                      widget.index == index ? colorList[index] : Colors.white),
              width: MediaQuery.of(context).size.width / 3.4,
              child: Center(
                  child: Text(
                nameList[index],
                style: TextStyle(
                    fontSize: 17,
                    color: widget.index == index ? Colors.white : Colors.black),
              )),
            ),
          );
        },
      ),
    );
  }
}
