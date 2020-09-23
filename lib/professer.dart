import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'example.dart';
import 'package:get/get.dart';

class Professer extends StatefulWidget {
  @override
  _ProfesserState createState() => _ProfesserState();
}

class _ProfesserState extends State<Professer> {
  TextEditingController _controller = new TextEditingController();
  _ProfesserState();
  graphco _graphco;
  @override
  Widget build(BuildContext context) {
    _graphco = Provider.of<graphco>(context);
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
      body: _graphco.pname.length == 0
          ? Center(
              child: Text("No Professer"),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  background: Container(color: Colors.red),
                  onDismissed: (direction) {
                    _graphco.deletep(index);
                  },
                  key: Key((index).toString()),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: ListTile(
                      dense: true,
                      leading: Icon(Icons.person),
                      title: Text(
                        _graphco.pname[index],
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            await edit(index);
                          }),
                    ),
                  ),
                );
              },
              itemCount: _graphco.pname.length,
            ),
    );
  }

  Future edit([int index = -1]) async {
    if (index != -1) {
      _controller.text = _graphco.pname[index];
    }
    await Get.bottomSheet(
        Container(
          padding: EdgeInsets.all(20),
          height: 250,
          child: Column(
            children: [
              Center(
                  child: Text(
                index == -1 ? "Add Teacher" : "Edit Teacher",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              )),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Teacher Name",
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 40,
                    width: 120,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        if (index != -1)
                          _graphco.updatep(index, _controller.text);
                        else
                          _graphco.addp(_controller.text);

                        Get.back();
                      },
                      child: Row(
                        children: [
                          Icon(
                            index == -1 ? Icons.add : Icons.edit,
                            color: Colors.white,
                          ),
                          Text(
                            index == -1 ? "  Create" : "  Update",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (index != -1)
                    Container(
                      height: 40,
                      width: 120,
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          _graphco.deletep(index);

                          Get.back();
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            Text(
                              "  Delete",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              )
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0))),
        ),
        shape: RoundedRectangleBorder(),
        elevation: 0);
    _controller.clear();
  }
}
