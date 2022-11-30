import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Mycontroller extends GetxController {
  RxString que1 = "security Question 1".obs;
  RxString que2 = "security Question 2".obs;
  RxBool eye_status = true.obs;
  RxString tra_type="credit".obs;
  RxBool view_data_Temp=false.obs;
  RxBool view_passbook_Temp=false.obs;
  RxList<Map>  list=<Map>[].obs;
  RxList<Map> passbok_list=<Map>[].obs;
  static SharedPreferences? pref;
  static Database? database;


 Future create_db() async {
    pref=await SharedPreferences.getInstance();
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE account (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, credit INTEGER, debit INTEGER , balance INTEGER)');
      await db.execute(
          'CREATE TABLE passbook (id INTEGER PRIMARY KEY AUTOINCREMENT, ac_id INTEGER, details  TEXT , debit INTEGER , credit INTEGER , date TEXT)');
    },);
    print("Database createdx..");
    return database;
  }
  create_account(String name)
  async {
      String qry="insert into account values (NULL,'$name',0,0,0)";
      int r_id=await database!.rawInsert(qry);
      print("r_id : $r_id");
  }
 Future view_account() async {
    String qry="select * from account";
    list.value=(await database!.rawQuery(qry));

    return list;
  }
  delete_account(int id)
  {
      String qry="delete from account where id=${id}";
      database!.rawDelete(qry);

  }
  upadate_account(int id,String name)
  {
          String qry="update account  set name='${name}' where id=${id}";
          print("Qry:${qry}");
          database!.rawUpdate(qry);
  }
  //--------------------------------
add_passBook_ENtry(int ac_id,String date, String type, int amt ,String description)
{
      int credit=0,debit=0;
      if(type=="credit"){
        credit=amt;
      }
      if(type=="debit"){
        debit=amt;
      }

      String qry="insert into passbook values(null,$ac_id,'$description',$debit,$credit,'$date')";
      print("Qry:$qry");
      database!.rawInsert(qry);

}
Future show_passbookEntry(int ac_id)async
{
  String qry="select * from passbook where ac_id=$ac_id";
  passbok_list.value= await (database!.rawQuery(qry));
  return passbok_list.value;
}

}
