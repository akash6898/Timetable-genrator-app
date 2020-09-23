import 'package:flutter/material.dart';
import 'example.dart';

class TableClass extends StatefulWidget {
  graphco g;
  TableClass(this.g);
  @override
  _TableClassState createState() => _TableClassState(g);
}

class _TableClassState extends State<TableClass> {
  graphco g;
  _TableClassState(this.g);
  @override
  Widget build(BuildContext context) {
    List<Widget> _ans = [];
    for (int i = 1; i <= g.m; i++) {
      List<Widget> _temp = [];
      for (int j = 0; j < g.result.length; j++) {
        if (g.result[j] == i) {
          _temp.add(Text(g.cname[widget.g.modifiedGraphIndex[j]]['name']));
          _temp.add(SizedBox(
            height: 10,
          ));
        }
      }
      _ans.add(Column(
        children: _temp,
      ));
      _ans.add(SizedBox(
        width: 10,
      ));
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Time Tabel"),
        ),
        body: Row(
          children: _ans,
        ));
  }
}
