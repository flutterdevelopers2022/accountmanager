import 'package:accountmanager/mycontroller.dart';
import 'package:accountmanager/passbook.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DashBoard extends StatelessWidget {
  TextEditingController t1 = TextEditingController();
  Mycontroller m = Get.put(Mycontroller());

  DashBoard() {
    m.view_account().then((value) {
      m.view_data_Temp.value = true;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: Obx(() => (m.view_data_Temp.value)
          ? ListView.builder(
            itemCount: m.list.value!=null ? m.list.value.length : 0,
            itemBuilder: (context, index) {
              return InkWell(onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PassBook_Entry(m.list.value[index]['id'],m.list.value[index]['name']);
                },));
              },child: Card(margin: EdgeInsets.all(10),
                shadowColor: Colors.black38,
                surfaceTintColor: Colors.red,
                elevation: 20,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(flex: 3,child:  Container(padding: EdgeInsets.only(left: 15),child: Text("${m.list.value[index]['name']}",style: TextStyle(fontSize: 25)),),),
                        Expanded(flex: 1,child: Container(child:Row(children: [ Expanded(child: IconButton(
                            onPressed: () {
                              t1.text="${m.list.value[index]['name']}";
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    insetPadding: EdgeInsets.all(2),
                                    title: Container(
                                      width: double.infinity,
                                      height: 50,
                                      alignment: Alignment.center,
                                      color: Colors.purple,
                                      child: Text(
                                        "Update Account",
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    content: Container(
                                      height: 40,
                                      margin: EdgeInsets.all(10),
                                      child: TextField(
                                        controller: t1,
                                        decoration: InputDecoration(
                                            hintText: "Account Name", border: OutlineInputBorder()),
                                      ),
                                    ),
                                    actions: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              margin: EdgeInsets.symmetric(vertical: 10),
                                              width: 100,
                                              height: 40,
                                              alignment: Alignment.center,
                                              child: Text(
                                                "CANCEL",
                                                style: TextStyle(color: Colors.purple),
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  border:
                                                  Border.all(color: Colors.purple, width: 2)),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              m.upadate_account(m.list.value[index]['id'],t1.text);
                                              Navigator.pop(context);

                                              t1.text = "";
                                              m.view_account();
                                            },
                                            child: Container(
                                              margin: EdgeInsets.symmetric(vertical: 10),
                                              width: 100,
                                              height: 40,
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Update",
                                                style: TextStyle(color: Colors.white),
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.purple,
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.edit_calendar))),
                          Expanded(
                            child: IconButton(
                                onPressed: () {
                                  showDialog(context: context, builder: (context) {
                                    return AlertDialog(title: Text("Are you sure for delete account"),
                                      actions: [
                                        TextButton(onPressed: () {
                                          Navigator.pop(context);
                                          m.delete_account(m.list.value[index]['id']);
                                          m.view_account();
                                        }, child: Text("Yes")),
                                        TextButton(onPressed: () {
                                          Navigator.pop(context);
                                        }, child: Text("no"))
                                      ],);
                                  },);
                                }, icon: Icon(Icons.delete)),
                          )],),))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 70,
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black12,
                            ),
                            child: Text("Credit \n Rs. ${m.list.value[index]['credit']}",maxLines: 2,textAlign: TextAlign.center,style: TextStyle(fontSize: 20),),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 70,
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black26,
                            ),
                            child: Text("Debit \n Rs. ${m.list.value[index]['debit']}",maxLines: 2,textAlign: TextAlign.center,style: TextStyle(fontSize: 20),),
                          ),
                        ),  Expanded(
                          child: Container(
                            height: 70,
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.purple,
                            ),
                            child: Text("Balance \n Rs. ${m.list.value[index]['balance']}",maxLines: 2,textAlign: TextAlign.center,style: TextStyle(fontSize: 20),),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),);
            },
          )
          : Center(
              child: CircularProgressIndicator(),
            )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_box_rounded),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                insetPadding: EdgeInsets.all(2),
                title: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  color: Colors.purple,
                  child: Text(
                    "Add new Account",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                content: Container(
                  height: 40,
                  margin: EdgeInsets.all(10),
                  child: TextField(
                    controller: t1,
                    decoration: InputDecoration(
                        hintText: "Account Name", border: OutlineInputBorder()),
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          child: Text(
                            "CANCEL",
                            style: TextStyle(color: Colors.purple),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: Colors.purple, width: 2)),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          m.create_account(t1.text);
                          t1.text = "";
                          Navigator.pop(context);
                          m.view_account();
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          child: Text(
                            "SAVE",
                            style: TextStyle(color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
