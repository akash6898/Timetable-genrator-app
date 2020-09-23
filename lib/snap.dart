import 'package:bidirectional_scroll_view/bidirectional_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'example.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';

class Grid extends StatefulWidget {
  graphco g;
  Grid(this.g);
  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  @override
  List<Widget> _data = [];
  Widget build(BuildContext context) {
    generate();
    return Scaffold(
      appBar: AppBar(
        title: Text("Grid"),
      ),
      body: new BidirectionalScrollViewPlugin(
        child: Container(
          child: Row(
            children: _data,
          ),
        ),
      ),
    );
  }

  void generate() {
    List<String> _day = [];
    List<int> _maxDays = [];
    int max = 0;
    widget.g.daytemp1.forEach((key, value) {
      _day.add(key);
      if (value > max) {
        max = value;
      }
    });
    for (int i = 0; i < _day.length; i++) {
      int temp1 = 0;
      for (int j = 0; j < widget.g.finaleTable[i].length; j++) {
        if (widget.g.finaleTable[i][j].length > temp1) {
          temp1 = widget.g.finaleTable[i][j].length;
        }
      }
      _maxDays.add(temp1);
    }
    for (int col = 0; col <= max; col++) {
      List<Widget> _temp1 = [];
      for (int row = 0; row < (_day.length + 1); row++) {
        if (col == 0 && row == 0) {
          _temp1.add(Container(
            width: 100,
            height: 40,
            decoration: BoxDecoration(border: Border.all(width: 0.5)),
          ));
          continue;
        }
        if (col == 0 && row >= 1 && _maxDays[row - 1] != 0) {
          _temp1.add(Container(
            width: 100,
            height: double.parse((40 * _maxDays[row - 1]).toString()),
            child: Center(child: Text(_day[row - 1])),
            decoration: BoxDecoration(border: Border.all(width: 0.5)),
          ));
          continue;
        }
        if (row == 0 && col >= 1) {
          _temp1.add(Container(
            width: 100,
            height: 40,
            child: Center(child: Text(col.toString())),
            decoration: BoxDecoration(border: Border.all(width: 0.5)),
          ));
          continue;
        }
        for (int no = 0; no < _maxDays[row - 1]; no++) {
          if (widget.g.finaleTable[row - 1].length > (col - 1) &&
              widget.g.finaleTable[row - 1][col - 1].length > no) {
            _temp1.add(Container(
              width: 100,
              height: 40,
              child: Center(
                child: Text(widget.g.cname[widget.g.modifiedGraphIndex[
                    widget.g.finaleTable[row - 1][col - 1][no]]]['name']),
              ),
              decoration: BoxDecoration(border: Border.all(width: 0.5)),
            ));
          } else {
            _temp1.add(Container(
              width: 100,
              height: 40,
              decoration: BoxDecoration(border: Border.all(width: 0.5)),
            ));
          }
        }
      }
      _data.add(Column(
        children: _temp1,
      ));
    }
  }
}
