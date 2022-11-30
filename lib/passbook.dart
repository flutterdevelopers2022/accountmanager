import 'package:accountmanager/mycontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PassBook_Entry extends StatelessWidget {
  int id = 0;
  String name = "";
  Mycontroller m = Get.put(Mycontroller());
  DateTime? dt;
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();

  PassBook_Entry(int id, String name) {
    this.id = id;
    this.name = name;

    m.show_passbookEntry(id).then((value) {
      m.view_passbook_Temp.value = true;
    });
  }
  get_date(BuildContext context)async
  {
    DateTime? dt= await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020), lastDate: DateTime(2023));
       String st=dt.toString().split(" ")[0];
       t3.text=st;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.purple,
            title: Text("${name}"),
            actions: [
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Container(
                            width: double.infinity,
                            height: 50,
                            alignment: Alignment.center,
                            color: Colors.purple,
                            child: Text(
                              "Add Transaction",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          content: SingleChildScrollView(
                            child: Container(
                              width: double.infinity,
                              height: 300,
                              // color: Colors.green,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TextField(controller: t3,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                            hintText: "Enter Date",
                                            suffixIcon: IconButton(
                                              onPressed: () {

                                              get_date(context);
                                              },
                                              icon: Icon(Icons.date_range),
                                            ))),
                                    Obx(
                                      () => Row(children: [
                                        Radio(
                                          value: "credit",
                                          groupValue: m.tra_type.value,
                                          onChanged: (value) {
                                            m.tra_type.value = value!;
                                          },
                                        ),
                                        Text(" Credit(+)"),
                                        Radio(
                                          value: "debit",
                                          groupValue: m.tra_type.value,
                                          onChanged: (value) {
                                            m.tra_type.value = value!;
                                          },
                                        ),
                                        Text(" Debit(-)"),
                                      ]),
                                    ),
                                    TextField(
                                      controller: t1,
                                      decoration: InputDecoration(
                                          labelText: "Amount",
                                          hintText: "Amount",
                                          border: OutlineInputBorder()),
                                    ),
                                    TextField(
                                      controller: t2,
                                      decoration: InputDecoration(
                                          labelText: "Description",
                                          hintText: "Description",
                                          border: OutlineInputBorder()),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 10),
                                            width: 100,
                                            height: 40,
                                            alignment: Alignment.center,
                                            child: Text(
                                              "EXIT",
                                              style: TextStyle(
                                                  color: Colors.purple),
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    color: Colors.purple,
                                                    width: 2)),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            m.add_passBook_ENtry(
                                                id,
                                                t3.text,
                                                m.tra_type.value,
                                                int.parse(t1.text),
                                                t2.text);
                                            t1.text = "";
                                            t2.text = "";
                                            t3.text="";
                                            Navigator.pop(context);
                                            m.show_passbookEntry(id);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 10),
                                            width: 100,
                                            height: 40,
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Save",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.purple,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ]),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.add_box_rounded)),
              IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_sharp))
            ]),
        body: Obx(
          () => (m.view_passbook_Temp.value)
              ? (m.passbok_list.value.length > 0)
                  ? Column(
                      children: [
                        Flexible(
                          child: Container(
                            color: Colors.black12,
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                    child: Container(
                                        width: double.infinity,
                                        margin: EdgeInsets.all(3),
                                        child: Text(
                                          "Date",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ))),
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                        width: double.infinity,
                                        margin: EdgeInsets.all(3),
                                        child: Text("Particular",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)))),
                                Expanded(
                                    child: Container(
                                        width: double.infinity,
                                        margin: EdgeInsets.all(3),
                                        child: Text("Credit Rs.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)))),
                                Expanded(
                                    child: Container(
                                        width: double.infinity,
                                        margin: EdgeInsets.all(3),
                                        child: Text("Debit Rs.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)))),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: m.passbok_list.value.length,
                            itemBuilder: (context, index) {
                              return Flexible(
                                child: Container(
                                  color:
                                      (index % 2 == 1) ? Colors.black12 : null,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                          child: Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.all(3),
                                              child: Text(
                                                "${m.passbok_list.value[index]['date']}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color:
                                                        (m.passbok_list.value[
                                                                        index]
                                                                    ['credit'] >
                                                                0)
                                                            ? Colors.green
                                                            : Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ))),
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.all(3),
                                              child: Text(
                                                  "${m.passbok_list.value[index]['details']}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: (m.passbok_list
                                                                          .value[
                                                                      index]
                                                                  ['credit'] >
                                                              0)
                                                          ? Colors.green
                                                          : Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16)))),
                                      Expanded(
                                          child: Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.all(3),
                                              child: Text(
                                                  "${m.passbok_list.value[index]['credit']}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: (m.passbok_list
                                                                          .value[
                                                                      index]
                                                                  ['credit'] >
                                                              0)
                                                          ? Colors.green
                                                          : Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16)))),
                                      Expanded(
                                          child: Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.all(3),
                                              child: Text(
                                                  "${m.passbok_list.value[index]['debit']}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: (m.passbok_list
                                                                          .value[
                                                                      index]
                                                                  ['credit'] >
                                                              0)
                                                          ? Colors.green
                                                          : Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16)))),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    )
                  : Center(
                      child: Text("No record Found"),
                    )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }
}
