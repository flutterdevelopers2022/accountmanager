import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

void main() {
  runApp(MaterialApp(
    home: Demo(),
  ));
}

class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  List l = [
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eihght",
    "nine",
    "ten",
    "eleven",
    "twelve",
    "thirteen",
    "fourteen",
    "fifteen",
    "sixteen",
    "first",
    "second",
    "third",
    "fourth",
    "five",
  ];
  late List<Widget> t;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    t = l
        .map((e) => Container(
              child: Text(e),
              width: 100,
              height: 100,
              color: Colors.grey,
            ))
        .toList();
    print(t);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Hello"),
        ),
        body: SlidableAutoCloseBehavior(closeWhenOpened: true,child: ListView.separated(
            itemBuilder: (context, index) {
              return Slidable(key: Key(l[index]),
                startActionPane:
                ActionPane(motion: ScrollMotion(),
                    dismissible: DismissiblePane(key: Key(l[index]),onDismissed: () {
                      l.removeAt(index);
                      setState(() {
                      });
                    },),
                    children: [
                      SlidableAction(
                        onPressed: (context) {},
                        icon: Icons.delete,
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                      ),
                      SlidableAction(
                        onPressed: (context) {},
                        icon: Icons.edit_calendar,
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,
                      ),
                    ]),
                child: ListTile(
                  title: Text(l[index]),
                  tileColor: Colors.lime,
                ),closeOnScroll: true,);
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: l.length)));
  }
}
