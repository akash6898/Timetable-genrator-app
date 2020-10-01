import 'package:bidirectional_scroll_view/bidirectional_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'example.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';

class Grid extends StatefulWidget {
  graphco g;
  int index = -1;
  Grid(this.g, [this.index = -1]);
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

  TimeOfDay plusMinutes(TimeOfDay time, int minutes) {
    if (minutes == 0) {
      return time;
    } else {
      int mofd = time.hour * 60 + time.minute;
      int newMofd = ((minutes % 1440) + mofd + 1440) % 1440;
      if (mofd == newMofd) {
        return time;
      } else {
        int newHour = newMofd ~/ 60;
        int newMinute = newMofd % 60;
        return TimeOfDay(hour: newHour, minute: newMinute);
      }
    }
  }

  void generate() {
    List<String> _day = [];
    Map<String, int> daytemp = {};
    List<int> _maxDays = [];
    List<dynamic> table = [];
    List<Map<String, dynamic>> _cname = [];
    List<int> _modifiedIndex = [];
    TimeOfDay startingTime;
    int min;
    if (widget.index == -1) {
      daytemp = widget.g.daytemp1;
      table = List.from(widget.g.finaleTable);
      _cname = List.from(widget.g.cname);
      _modifiedIndex = List.from(widget.g.modifiedGraphIndex);
      startingTime = widget.g.startTime;
      min = widget.g.minutes;
    } else {
      widget.g.timeTableList[widget.index]['day'].forEach((key, value) {
        daytemp[key.toString()] = int.parse(value.toString());
      });
      table =
          new List<dynamic>.from(widget.g.timeTableList[widget.index]['list']);
      _cname = List.from(widget.g.timeTableList[widget.index]['courseList']);
      _modifiedIndex =
          List.from(widget.g.timeTableList[widget.index]['graphindex']);
      int hr = widget.g.timeTableList[widget.index]['hr'];
      int mi = widget.g.timeTableList[widget.index]['mi'];
      startingTime = TimeOfDay(hour: hr, minute: mi);
      min = widget.g.timeTableList[widget.index]['minute'];
    }
    int max = 0;
    daytemp.forEach((key, value) {
      _day.add(key);
      if (value > max) {
        max = value;
      }
    });
    List<TimeOfDay> colName = [];
    for (int i = 0; i <= max; i++) {
      colName.add(plusMinutes(startingTime, min * i));
    }
    for (int i = 0; i < _day.length; i++) {
      int temp1 = 0;
      for (int j = 0; j < table[i].length; j++) {
        if (table[i][j].length > temp1) {
          temp1 = table[i][j].length;
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
            child: Center(
                child: Text(
                    "${colName[col - 1].hour.toString()}:${colName[col - 1].minute.toString()} - ${colName[col].hour.toString()}:${colName[col].minute.toString()}")),
            decoration: BoxDecoration(border: Border.all(width: 0.5)),
          ));
          continue;
        }
        for (int no = 0; no < _maxDays[row - 1]; no++) {
          if (table[row - 1].length > (col - 1) &&
              table[row - 1][col - 1].length > no) {
            _temp1.add(Container(
              width: 100,
              height: 40,
              child: Center(
                child: Text(_cname[_modifiedIndex[table[row - 1][col - 1][no]]]
                    ['name']),
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
