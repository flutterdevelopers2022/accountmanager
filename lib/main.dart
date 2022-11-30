import 'package:accountmanager/mycontroller.dart';
import 'package:accountmanager/passbook.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
//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
import 'dashboard.dart';
import 'firstscreen.dart';

 main()  {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  Mycontroller m = Get.put(Mycontroller());
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
    Home()
    {
      m.create_db();
    }
  set_pass(BuildContext context) async {
    Mycontroller.pref!=await SharedPreferences.getInstance();
    if(Mycontroller.pref!.getString("pass")!=null)
    {
      Get.to(FirstScreen());
    }else
    {
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
                "Settings",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            content: Container(
              width: double.infinity,
              height: 400,
              // color: Colors.green,
              child: SingleChildScrollView(
                child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Obx(() => TextField(controller: t1,obscureText: m.eye_status.value ? true : false,
                    decoration: InputDecoration(
                        labelText: "SetPassword",
                        suffixIcon: IconButton(
                            onPressed: () {
                              m.eye_status.value = !m.eye_status.value;
                            },
                            icon: (m.eye_status.value)
                                ? Icon(FontAwesomeIcons.eyeSlash)
                                : Icon(FontAwesomeIcons.eye)),
                        hintText: "Set Password",
                        border: OutlineInputBorder()),
                  )),
                  // IconButton(onPressed: null, icon: FaIcon(FontAwesomeIcons.eye)),
                  // Spacer(),
                  Obx(() => Container(
                    margin: EdgeInsets.only(top: 20),
                    child: DropdownButton(
                      isExpanded: true,
                      value: m.que1.value,
                      items: [
                        DropdownMenuItem(
                          child: Text("security Question 1"),
                          value: "security Question 1",
                        ),
                        DropdownMenuItem(
                          child: Text(
                              "what is the first mobile that you purchased ?"),
                          value:
                          "what is the first mobile that you purchased ?",
                        ),
                        DropdownMenuItem(
                          child: Text(
                              "what is the name of your best friend at childhood?"),
                          value:
                          "what is the name of your best friend at childhood?",
                        ),
                      ],
                      onChanged: (value) {
                        m.que1.value = value.toString();
                      },
                    ),
                  )),
                  TextField(controller: t2,
                    decoration: InputDecoration(
                        labelText: "Answer 1",
                        hintText: "Answer 1",
                        border: OutlineInputBorder()),
                  ),
                  Obx(() => Container(
                    margin: EdgeInsets.only(top: 20),
                    child: DropdownButton(
                      isExpanded: true,
                      value: m.que2.value,
                      items: [
                        DropdownMenuItem(
                          child: Text("security Question 2"),
                          value: "security Question 2",
                        ),
                        DropdownMenuItem(
                          child: Text(
                              "what is the first mobile that you purchased ?"),
                          value:
                          "what is the first mobile that you purchased ?",
                        ),
                        DropdownMenuItem(
                          child: Text(
                              "what is the name of your best friend at childhood?"),
                          value:
                          "what is the name of your best friend at childhood?",
                        ),
                      ],
                      onChanged: (value) {
                        m.que2.value = value.toString();
                      },
                    ),
                  )),
                  TextField(controller: t3,
                    decoration: InputDecoration(
                        labelText: "Answer 2",
                        hintText: "Answer 2",
                        border: OutlineInputBorder()),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        width: 100,
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(
                          "EXIT",
                          style: TextStyle(color: Colors.purple),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.purple, width: 2)),
                      ),
                      InkWell(onTap: () async {

                        String pass,que1,que2;
                        pass=t1.text;
                        que1=t2.text;
                        que2=t3.text;
                        await  Mycontroller.pref!.setString("pass", pass);
                        await  Mycontroller.pref!.setString("ans1", que1);
                        await  Mycontroller.pref!.setString("ans2", que2);

                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                          return FirstScreen();
                        },));
                      },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          child: Text(
                            "SET",
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
                ]),
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    Future.delayed(Duration.zero,() {
      set_pass(context);
    },);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              color: Colors.blueGrey,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("image/background.jpg")))),
    );
  }
}
