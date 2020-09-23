import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'example.dart';
import 'package:get/get.dart';
import 'courseedit.dart';

class Course extends StatefulWidget {
  @override
  _CourseState createState() => _CourseState();
}

class _CourseState extends State<Course> {
  graphco g;

  int _value = -1;
  List<Map<String, dynamic>> _clist = [];
  @override
  Widget build(BuildContext context) {
    g = Provider.of<graphco>(context);
    _clist.clear();
    g.cname.forEach((value) {
      _clist.add({
        'cname': value['name'],
        'credit': value['credit'],
        'index': value['index']
      });
    });
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.all(10),
        child: IconButton(
            icon: Icon(
              Icons.add_circle,
              size: 50,
              color: Colors.blue,
            ),
            onPressed: () async {
              await edit();
            }),
      ),
      body: _clist.length == 0
          ? Center(
              child: Text("No Subject"),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return courseList(index);
              },
              itemCount: _clist.length,
            ),
    );
  }

  Future edit([int key = -1]) async {
    await Get.bottomSheet(CourseEdit(g, key),
        shape: RoundedRectangleBorder(), elevation: 0);
  }

  Widget courseList(int index) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(color: Colors.red),
      onDismissed: (direction) {
        g.deletec(index);
        _clist.removeAt(index);
      },
      key: UniqueKey(),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: ListTile(
          dense: true,
          leading: Icon(Icons.person),
          title: Text(
            _clist[index]['cname'],
            style: TextStyle(fontSize: 16),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text("Credits:  ${_clist[index]['credit']}"),
              SizedBox(
                height: 10,
              ),
              Text("Teacher:  ${g.pname[_clist[index]['index']]}")
            ],
          ),
          trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () async {
                await edit(index);
              }),
        ),
      ),
    );
  }
}
