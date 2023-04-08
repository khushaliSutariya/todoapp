import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandlers {
  Database? db;
  Future<Database?> create_db() async {
    if (db != null) {
      return db;
    } else {
      Directory dir = await getApplicationDocumentsDirectory();
      String dppath = join(dir.path, "notes_db");
      var db = await openDatabase(dppath, version: 1, onCreate: create_table);
      return db;
    }
  }

  create_table(Database db, int version) {
    db.execute("create table notesdata (tid integer primary key autoincrement, title text,remark text,date text)");
    print("Table created");
  }

 Future<int?> insertdata(addtitle,addremark,adddate) async{
    var idb = await create_db();
    var id =await idb?.rawInsert("insert into notesdata (title,remark,date) values (?,?,?)",[addtitle,addremark,adddate]);
    return id;
  }
  Future<List> viewdata() async {
    var idb = await create_db();
    var data = await idb!.rawQuery("select * from notesdata");
    return data!.toList();

  }
  Future<int> deletedata(id) async{
    var idb = await create_db();
    var status = await idb!.rawDelete("delete from notesdata where tid=?",[id]);
  return status;
  }
 Future<List> getsingledata(id) async{
    var idb = await create_db();
    var data = await idb!.rawQuery("select * from notesdata where tid=?",[id]);
    return data.toList();
  }
  Future<int> updatedata(addtitle, addremark, adddate,id) async{
    
    var idb = await create_db();
    var status = await idb!.rawUpdate("update notesdata set title=?,remark=?,date=? where tid=?",[addtitle, addremark, adddate,id]);
    return status;

  }
}
