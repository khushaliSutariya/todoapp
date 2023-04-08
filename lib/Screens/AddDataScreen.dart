import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/Screens/Homepage.dart';

import 'Helpers/DatabaseHandlers.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({Key? key}) : super(key: key);

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  TextEditingController _title = TextEditingController();
  TextEditingController _remark = TextEditingController();
  TextEditingController _date = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Title",
                  style: TextStyle(
                      fontFamily: "Roboto", fontSize: 20, color: Colors.brown),
                ),
                TextFormField(
                  controller: _title,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text("Remark",
                    style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 20,
                        color: Colors.brown)),
                TextFormField(
                  controller: _remark,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text("Date",
                    style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 20,
                        color: Colors.brown)),
                TextFormField(
                  controller: _date,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.calendar_today,),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      print(pickedDate);
                      String formattedDate =
                          DateFormat('dd-mm-yyyy').format(pickedDate);
                      print(formattedDate);
                      setState(() {
                        _date.text = formattedDate;
                      });
                    } else {}
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        var addtitle = _title.text.toString();
                        var addremark = _remark.text.toString();
                        var adddate = _date.text.toString();
                        DatabaseHandlers obj = DatabaseHandlers();
                        var nid =
                            await obj.insertdata(addtitle, addremark, adddate);
                        print("Record inserted" + nid.toString());
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Homepage(),));
                      },
                      child: Text("Add")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
