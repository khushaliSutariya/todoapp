import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Helpers/DatabaseHandlers.dart';
import 'Homepage.dart';
class UpdateNotes extends StatefulWidget {
 var updateid = '';
 UpdateNotes({required this.updateid});
 @override
  State<UpdateNotes> createState() => _UpdateNotesState();
}

class _UpdateNotesState extends State<UpdateNotes> {
  TextEditingController _title = TextEditingController();
  TextEditingController _remark = TextEditingController();
  TextEditingController _date = TextEditingController();


  getsingle() async{
    DatabaseHandlers obj = new DatabaseHandlers();
    var data = await obj.getsingledata(widget.updateid);
    setState(() {
      _title.text = data[0]["title"].toString();
      _remark.text = data[0]["remark"].toString();
      _date.text = data[0]["date"].toString();
    });

  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getsingle();
  }
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
                        DatabaseHandlers obj = new DatabaseHandlers();
                        var nid =
                        await obj.updatedata(addtitle, addremark, adddate,widget.updateid);
                        if(nid == 1){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Homepage(),));
                        }
                        else{
                          print("error");
                        }

                      },
                      child: Text("Save")),
                )
              ],
            ),
          ),
        ),
      ),
    );

  }
}
