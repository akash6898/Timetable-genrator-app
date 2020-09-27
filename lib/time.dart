import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'example.dart';
import 'package:get/get.dart';
import 'select.dart';

class Time extends StatelessWidget {
  graphco g;
  @override
  Widget build(BuildContext context) {
    g = Provider.of<graphco>(context);
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.all(10),
        child: IconButton(
            icon: Icon(
              Icons.add_circle,
              size: 50,
              color: Colors.blue,
            ),
            onPressed: () {
              Get.to(Select(g));
            }),
      ),
      body: g.finallist.length == 0
          ? Center(
              child: Text("No TimeTable"),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  background: Container(color: Colors.red),
                  onDismissed: (direction) {},
                  key: UniqueKey(),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: ListTile(
                      onTap: () {},
                      dense: true,
                      leading: Icon(Icons.grid_on),
                      title: Text(
                        g.timeTableList[index]['name'],
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            // await edit(index);
                          }),
                    ),
                  ),
                );
              },
              itemCount: g.timeTableList.length,
            ),
    );
  }
}
