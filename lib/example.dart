import 'dart:convert';
import 'dart:io';
import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class graphco extends ChangeNotifier {
  int v = 4;
  List<String> modifiedGraph = new List();
  List<int> modifiedGraphIndex = new List();
  List<List<List<int>>> finaleTable = new List();
  List<Map<String, dynamic>> finallist = new List();
  List<Map<String, dynamic>> timeTableList = new List();
  List<List<bool>> graph = [];
  List<List<int>> adj;
  int m;
  int room = 2;
  TimeOfDay startTime;
  int minutes;
  String tableName;
  List<int> result;
  List<String> pname = new List();
  Map<String, int> daytemp1 = {};
  List<Map<String, dynamic>> cname = [];
  SharedPreferences prefs;
  Map<String, int> daytemp = {
    'Mon': 0,
    'Tue': 0,
    'Wed': 0,
    'Thu': 0,
    'Fri': 0,
    'Sat': 0,
    'Sun': 0,
  };

  Future<bool> setStorage() async {
    prefs = await SharedPreferences.getInstance();
    String data = prefs.getString("data");
    print(data);
    if (data != null) {
      print("enter");
      Map<String, dynamic> jsonData = await json.decode(data);
      print(jsonData);
      pname = new List.from(jsonData['name_of_p']);
      cname = new List.from(jsonData['name_of_c']);
      timeTableList = new List.from(jsonData['time_table_list']);
    }
    return true;
  }

  void save() {
    Map<String, dynamic> jsonData = {
      'name_of_p': pname,
      'name_of_c': cname,
      'time_table_list': timeTableList,
    };
    prefs.setString("data", json.encode(jsonData));
  }

  void addp(String s) {
    pname.add(s);
    save();
    notifyListeners();
  }

  void updatep(int index, String name) {
    pname[index] = name;
    save();
    notifyListeners();
  }

  void selectm(int x) {
    m = 1;
  }

  void addcname(String name, int index, int credit) {
    Map<String, dynamic> temp = {
      'name': name,
      'index': index,
      'credit': credit
    };
    cname.add(temp);
    save();
    notifyListeners();
  }

  void deletec(int index) {
    print("c");
    print(cname);
    cname.removeAt(index);
    print(cname);
    save();
    notifyListeners();
  }

  void updatec(int key, String name, int credit, int index) {
    cname[key] = {'name': name, 'credit': credit, 'index': index};
    save();
    notifyListeners();
  }

  void deletep(int index) {
    for (int i = 0; i < cname.length; i++) {
      if (cname[i]['index'] > index) {
        cname[i]['index']--;
      }
      if (cname[i]['index'] == index) {
        cname[i]['index'] = -1;
      }
    }
    pname.removeAt(index);
    save();
    notifyListeners();
  }

  void showp() {
    if (pname.length == 0) {
      print("No professer");
      return;
    }
    for (int i = 0; i < pname.length; i++) {
      print("$i ${pname[i]}");
    }
  }

  void showc() {
    if (cname.length == 0) {
      print("No course");
      return;
    }
    cname.forEach((value) {
      print("${value['name']} ${value['index']} ${value['credit']}");
    });
  }

  bool isSafe(List<List<bool>> graph, List<int> color) {
    // check for every edge
    for (int i = 0; i < v; i++)
      for (int j = i + 1; j < v; j++)
        if (graph[i][j] && color[j] == color[i]) return false;
    return true;
  }

  bool graphColoring(List<List<bool>> graph, int m, int i, List<int> color) {
    if (i == v) {
      if (isSafe(graph, color)) {
        printSolution(color);
        return true;
      }
      return false;
    }

    for (int j = 1; j <= m; j++) {
      color[i] = j;

      if (graphColoring(graph, m, i + 1, color)) return true;

      color[i] = 0;
    }

    return false;
  }

  void printSolution(List<int> color) {
    print("Solution Exists:"
        " Following are the assigned colors \n");
    for (int i = 0; i < v; i++) print(color[i]);
    print("\n");
    int max = 1;
    List<String> _daykeys = [];
    daytemp.forEach((key, value) {
      if (value > 0) {
        daytemp1[key] = value;
        _daykeys.add(key);
      }
      if (value > max) {
        max = value;
      }
    });
    int index = 1;
    List<List<int>> indexList = [];
    for (int row = 1; row <= daytemp1.length; row++) {
      List<int> _temp1 = [];
      for (int col = 1; col <= daytemp[_daykeys[row - 1]]; col++) {
        _temp1.add(0);
      }
      indexList.add(_temp1);
    }
    int _itemp = 1;
    for (int j = 1; j <= max; j++) {
      for (int i = 1; i <= daytemp1.length; i++) {
        if (j <= daytemp[_daykeys[i - 1]]) {
          indexList[i - 1][j - 1] = _itemp;
          _itemp++;
        }
      }
    }
    for (int i = 0; i < indexList.length; i++) {
      for (int j = 0; j < indexList[i].length; j++) {
        print(indexList[i][j]);
      }
      print("next");
    }
    for (int row = 1; row <= daytemp1.length; row++) {
      List<List<int>> _temp1 = [];
      for (int col = 1; col <= daytemp[_daykeys[row - 1]]; col++) {
        List<int> _temp = [];
        for (int i = 0; i < v; i++) {
          if ((color[i] + 1) == indexList[row - 1][col - 1]) {
            _temp.add(i);
          }
        }
        index++;
        _temp1.add(_temp);
      }
      finaleTable.add(_temp1);
    }
    timeTableList.add({
      'name': tableName,
      'start_time': startTime.toString(),
      'minute': minutes,
      'list': finaleTable,
      'day': daytemp1,
      'created hr': TimeOfDay.now().toString(),
      'courseList': cname,
      'professerList': pname,
      'graphindex': modifiedGraphIndex
    });
    save();
    notifyListeners();
    print(finaleTable);
  }

  addEdge(int v, int w) {
    adj[v].add(w);
    adj[w].add(v); // Note: the graph is undirected
  }

  void solution() {
    int count = 0;
    //  modifiedGraph.clear();
    modifiedGraphIndex.clear();
    finaleTable.clear();
    daytemp1.clear();
    daytemp.forEach((key, value) {
      count = count + value;
    });
    selectm(count);
    int temp = 0;
    int ind = 0;
    cname.forEach((value) {
      temp = temp + value['credit'];
      for (int i = 0; i < value['credit']; i++) {
        modifiedGraphIndex.add(ind);
      }
      ind++;
    });
    v = temp;
    adj = new List(v);
    for (int i = 0; i < v; i++) {
      adj[i] = new List();
    }
    print(modifiedGraphIndex);
    print(cname);
    for (int i = 0; i < v; i++) {
      List<bool> temp2 = new List();
      for (int j = 0; j < v; j++) {
        if (i == j) {
          //temp2.add(false);
        } else {
          if (cname[modifiedGraphIndex[i]]['name'] ==
              cname[modifiedGraphIndex[j]]['name']) {
            addEdge(i, j);
          } else if (cname[modifiedGraphIndex[i]]['index'] ==
              cname[modifiedGraphIndex[j]]['index']) {
            addEdge(i, j);
          } else {
            //temp2.add(false);
          }
        }
      }
      graph.add(temp2);
    }
    print(graph);
    print("finsih");
    greedyColoring();
  }

  greedyColoring() {
    result = new List(v);
    result[0] = 0;

    for (int u = 1; u < v; u++) result[u] = -1; // no color is assigned to u

    // A temporary array to store the available colors. True
    // value of available[cr] would mean that the color cr is
    // assigned to one of its adjacent vertices
    List<bool> available = new List(v);
    List<int> availableroom = new List(v);
    for (int cr = 0; cr < v; cr++) {
      available[cr] = false;
      availableroom[cr] = 0;
    }
    availableroom[0] = 1;

    // Assign colors to remaining V-1 vertices
    for (int u = 1; u < v; u++) {
      // Process all adjacent vertices and flag their colors
      // as unavailable
      int i;

      for (i = 0; i != adj[u].length; ++i) {
        if (result[adj[u][i]] != -1) {
          available[result[adj[u][i]]] = true;
        }
      }

      // Find the first available color
      int cr;
      int check = 0;
      for (cr = 0; cr < v; cr++) {
        if (available[cr] == false) {
          if (availableroom[cr] < room) {
            print("entered");
            check = 1;
            break;
          }
        }
      }
      if (check == 1) {
        result[u] = cr;
        availableroom[cr]++;
      } // Assign the found color

      // Reset the values back to false for the next iteration
      for (i = 0; i != adj[u].length; ++i)
        if (result[adj[u][i]] != -1) {
          available[result[adj[u][i]]] = false;
          // availableroom[result[adj[u][i]]] = 0;
        }
    }

    // print the result
    printSolution(result);
  }
}
