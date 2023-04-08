import 'package:flutter/material.dart';
import 'package:todoapp/Screens/Helpers/DatabaseHandlers.dart';
import 'package:todoapp/Screens/UpdateNotes.dart';

import 'AddDataScreen.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future<List>? allnotes;
  Future<List> getdata() async {
    DatabaseHandlers obj = DatabaseHandlers();
    var alldata = await obj.viewdata();
    return alldata;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      allnotes = getdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notes"), actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem(child: Text("sync")),
              PopupMenuItem(child: Text("Setup")),
            ];
          },
        )
      ]),
      body: FutureBuilder(
        future: allnotes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length == 0) {
              return Center(
                child: Text("No data"),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: 8.0, right: 8.0, top: 5.0, bottom: 5.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.red.shade300),
                      child: Card(
                        color: Colors.green.shade50,
                        elevation: 5.0,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                snapshot.data![index]["title"].toString(),
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 15,
                                    ),
                              ),
                              subtitle: Text(
                                  snapshot.data![index]["remark"].toString(),
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 15,
                                ),),
                              trailing: Text(
                                  snapshot.data![index]["date"].toString(),style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 15,
                              ),),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(onPressed: () async {
                                 var id =  snapshot.data![index]["tid"].toString();
                                DatabaseHandlers obj = new DatabaseHandlers();
                               var st = await obj.deletedata(id);
                               if(st == 1){
                                    setState(() {
                                      allnotes = getdata();
                                    });
                               }
                               else{
                                 print("Error");
                               }
                                }, child: Text("Delete")),
                                ElevatedButton(onPressed: () {
                                  var id =  snapshot.data![index]["tid"].toString();
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdateNotes(updateid: id),));
                                }, child: Text("Update")),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddDataScreen(),
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
