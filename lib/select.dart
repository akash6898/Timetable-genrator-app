import 'package:flutter/material.dart';
import 'example.dart';
import 'package:get/get.dart';
import 'table.dart';
import 'snap.dart';

class Select extends StatefulWidget {
  graphco g;
  Select(this.g);
  @override
  _SelectState createState() => _SelectState();
}

class _SelectState extends State<Select> {
  TextEditingController _controller = new TextEditingController();
  TextEditingController _controller1 = new TextEditingController();
  graphco g;
  TimeOfDay time;
  int i = 0;
  @override
  void initState() {
    g = widget.g;
    super.initState();
  }

  List<String> _day = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  @override
  Widget build(BuildContext context) {
    List<Widget> _list = [];
    _day.forEach((element) {
      _list.add(Container(
        decoration: BoxDecoration(
            color:
                g.daytemp[element] == 0 ? Colors.grey.shade300 : Colors.green),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 1),
        child: Column(
          children: [
            Text(element),
            SizedBox(
              height: 10,
            ),
            IconButton(
                icon: Icon(Icons.keyboard_arrow_up),
                onPressed: () {
                  setState(() {
                    g.daytemp[element]++;
                  });
                }),
            SizedBox(
              height: 10,
            ),
            Text(g.daytemp[element].toString()),
            SizedBox(
              height: 10,
            ),
            IconButton(
                icon: Icon(Icons.keyboard_arrow_down),
                onPressed: () {
                  setState(() {
                    if (g.daytemp[element] > 0) g.daytemp[element]--;
                  });
                }),
          ],
        ),
      ));
    });
    return Scaffold(
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 40,
          padding: EdgeInsets.zero,
          child: RaisedButton(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.all(0),
            onPressed: () {
              g.startTime = time;
              g.minutes = int.parse(_controller.text);
              g.tableName = _controller1.text;
              g.solution();
              Get.off(Grid(g));
            },
            child: Text(
              "Next",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
            ),
          ),
        ),
        appBar: AppBar(
          title: Text("Generate New TimeTable"),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.zero,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(children: [
                TextField(
                  controller: _controller1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter the name of timetable",
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Starting Time:-",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          await _pickTime();
                        },
                        child: Container(
                          height: 40,
                          decoration:
                              BoxDecoration(border: Border.all(width: 0.5)),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: EdgeInsets.all(6),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(time == null
                                          ? "Select Time"
                                          : "${time.hour} : ${time.minute} "),
                                      Icon(Icons.access_time)
                                    ],
                                  ))),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Period duration in minutes",
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _list),
              ]),
            ),
          ),
        ));
  }

  Future _pickTime() async {
    TimeOfDay t =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (t != null)
      setState(() {
        time = t;
      });
  }
}
// Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Center(
//             child: Row(
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.remove),
//                   onPressed: () {
//                     setState(() {
//                       i--;
//                     });
//                   },
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Text(i.toString()),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.add),
//                   onPressed: () {
//                     setState(() {
//                       i++;
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Center(
//             child: RaisedButton(
//               onPressed: () {
//                 g.selectm(i);
//                 g.solution();
//                 print(g.modifiedGraph.length);
//                 Get.to(TableClass(g));
//               },
//               child: Text("continue"),
//             ),
//           )
//         ],
//       ),
