import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'example.dart';

class CourseEdit extends StatefulWidget {
  graphco g;
  int _key;
  int index = -1;
  CourseEdit(this.g, this._key);
  @override
  _CourseEditState createState() => _CourseEditState();
}

class _CourseEditState extends State<CourseEdit> {
  TextEditingController _controller = new TextEditingController();
  TextEditingController _controller1 = new TextEditingController();
  int _value = -1;
  bool _vis = false;
  @override
  void initState() {
    if (widget._key != -1) {
      _controller.text = widget.g.cname[widget._key]['name'];
      _controller1.text = widget.g.cname[widget._key]['credit'].toString();
      _value = widget.g.cname[widget._key]['index'];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // KeyboardVisibilityNotification().addNewListener(
    //   onChange: (bool visible) {
    //     _vis = visible;
    //   },
    // );
    print("d");
    print(widget._key);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        height: 400,
        child: Column(
          children: [
            Center(
                child: Text(
              widget._key == -1 ? "Add Course" : "Edit Course",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _controller,
              autofocus: true,
              onTap: () {
                FocusScope.of(context).requestFocus();
                _vis = true;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Course Name",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _controller1,
              onTap: () {
                FocusScope.of(context).requestFocus();
                _vis = true;
              },
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Course Credit",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Teacher Name:-",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
                dropDown(),
              ],
            ),
            SizedBox(
              height: 20,
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
                      if (widget._key != -1) {
                        widget.g.updatec(widget._key, _controller.text,
                            int.parse(_controller1.text), _value);
                      } else
                        widget.g.addcname(_controller.text, _value,
                            int.parse(_controller1.text));
                      _controller.clear();
                      _controller1.clear();
                      _value = -1;

                      Get.back();
                    },
                    child: Row(
                      children: [
                        Icon(
                          widget._key == -1 ? Icons.add : Icons.edit,
                          color: Colors.white,
                        ),
                        Text(
                          widget._key == -1 ? "  Create" : "  Update",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ),
                if (widget._key != -1)
                  Container(
                    height: 40,
                    width: 120,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        widget.g.deletec(widget._key);
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
    );
  }

  Widget dropDown() {
    List<DropdownMenuItem<int>> _items = [];
    _items.add(DropdownMenuItem<int>(
      value: -1,
      child: Text("None"),
    ));
    for (int i = 0; i < widget.g.pname.length; i++) {
      _items.add(DropdownMenuItem<int>(
        value: i,
        child: Text(widget.g.pname[i]),
      ));
    }
    return DropdownButton<int>(
      hint: Text("Select Catagoy"),
      value: _value,
      onTap: () async {
        if (_vis) {
          FocusScope.of(context).unfocus();
          _vis = false;

          Get.back();
        }
      },
      autofocus: true,
      onChanged: (int value) {
        print(value);
        setState(() {
          _value = value;
        });
      },
      icon: Icon(Icons.arrow_downward),
      items: _items,
    );
  }
}
