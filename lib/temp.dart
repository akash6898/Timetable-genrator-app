// import 'dart:io';
// import 'dart:io';
// import 'package:path/path.dart';
// import 'package:excel/excel.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class graphco {
//   int v = 4;
//   List<String> modifiedGraph = new List();
//   List<int> modifiedGraphIndex = new List();
//   List<List<List<int>>> finaleTable = new List();
//   List<List<bool>> graph = [];
//   List<List<int>> adj;
//   int m;
//   TimeOfDay startTime;
//   int minutes;
//   List<int> color;
//   List<String> pname = new List();
//   Map<String, int> daytemp1 = {};
//   List<Map<String, dynamic>> cname = [];
//   Map<String, int> daytemp = {
//     'Mon': 0,
//     'Tue': 0,
//     'Wed': 0,
//     'Thu': 0,
//     'Fri': 0,
//     'Sat': 0,
//     'Sun': 0,
//   };

//   void addp(String s) {
//     pname.add(s);
//   }

//   void selectm(int x) {
//     m = x;
//   }

//   void addcname(String name, int index, int credit) {
//     Map<String, dynamic> temp = {
//       'name': name,
//       'index': index,
//       'credit': credit
//     };
//     cname.add(temp);
//   }

//   void deletec(int index) {
//     print("c");
//     print(index);
//     cname.remove(index);
//   }

//   void deletep(int index) {
//     for (int i = 0; i < cname.length; i++) {
//       if (cname[i]['index'] > index) {
//         cname[i]['index']--;
//       }
//       if (cname[i]['index'] == index) {
//         cname[i]['index'] = -1;
//       }
//     }
//     pname.removeAt(index);
//   }

//   void showp() {
//     if (pname.length == 0) {
//       print("No professer");
//       return;
//     }
//     for (int i = 0; i < pname.length; i++) {
//       print("$i ${pname[i]}");
//     }
//   }

//   void showc() {
//     if (cname.length == 0) {
//       print("No course");
//       return;
//     }
//     cname.forEach((value) {
//       print("${value['name']} ${value['index']} ${value['credit']}");
//     });
//   }

//   bool isSafe(List<List<bool>> graph, List<int> color) {
//     // check for every edge
//     for (int i = 0; i < v; i++)
//       for (int j = i + 1; j < v; j++)
//         if (graph[i][j] && color[j] == color[i]) return false;
//     return true;
//   }

//   bool graphColoring(List<List<bool>> graph, int m, int i, List<int> color) {
//     if (i == v) {
//       if (isSafe(graph, color)) {
//         printSolution(color);
//         return true;
//       }
//       return false;
//     }

//     for (int j = 1; j <= m; j++) {
//       color[i] = j;

//       if (graphColoring(graph, m, i + 1, color)) return true;

//       color[i] = 0;
//     }

//     return false;
//   }

//   void printSolution(List<int> color) {
//     print("Solution Exists:"
//         " Following are the assigned colors \n");
//     for (int i = 0; i < v; i++) print(color[i]);
//     print("\n");
//     int max = 1;
//     daytemp.forEach((key, value) {
//       if (value > 0) {
//         daytemp1[key] = value;
//       }
//       if (value > max) {
//         max = value;
//       }
//     });
//     for (int row = 1; row <= daytemp1.length; row++) {
//       List<List<int>> _temp1 = [];
//       for (int col = 1; col <= max; col++) {
//         int index = row + (daytemp1.length) * (col - 1);
//         List<int> _temp = [];
//         for (int i = 0; i < v; i++) {
//           if (color[i] == index) {
//             _temp.add(i);
//           }
//         }
//         _temp1.add(_temp);
//       }
//       finaleTable.add(_temp1);
//     }
//     print(finaleTable);
//   }
//   addEdge(int v, int w)
// {
//     adj[v].add(w);
//     adj[w].add(v);  // Note: the graph is undirected
// }
//   void solution() {
//     // for (int co = 0; co < 10000000; co++) {
//     //   for (int co1 = 0; co1 < 10000000; co1++) {}
//     // }
//     int count = 0;
//     modifiedGraph.clear();
//     modifiedGraphIndex.clear();
//     finaleTable.clear();
//     daytemp1.clear();
//     daytemp.forEach((key, value) {
//       count = count + value;
//     });
//     selectm(count);
//     int temp = 0;
//     int ind = 0;
//     cname.forEach((value) {
//       temp = temp + value['credit'];
//       for (int i = 0; i < value['credit']; i++) {
//         modifiedGraph.add(value['name']);
//         modifiedGraphIndex.add(ind);
//       }
//       ind++;
//     });
//     v = temp;
//     adj = new List(v);
//     color = new List(v);
//     for (int i = 0; i < v; i++) {
//       color[i] = 0;
//     }
//     print(modifiedGraphIndex);
//     print(cname);
//     for (int i = 0; i < v; i++) {
//       List<bool> temp2 = new List();
//       for (int j = 0; j < v; j++) {
//         if (i == j) {
//           temp2.add(false);
//         } else {
//           if (modifiedGraph[i] == modifiedGraph[j]) {
//             temp2.add(true);
//           } else if (cname[modifiedGraphIndex[i]]['index'] ==
//               cname[modifiedGraphIndex[j]]['index']) {
//             temp2.add(true);
//           } else {
//             temp2.add(false);
//           }
//         }
//       }
//       graph.add(temp2);
//     }
//     print(graph);
//     print("finsih");
//     if (!graphColoring(graph, m, 0, color)) print("Solution does not exist");
//   }

//   greedyColoring()
// {
//     List<int> result = new List(v);

//     // Assign the first color to first vertex
//     result[0]  = 0;

//     // Initialize remaining V-1 vertices as unassigned
//     for (int u = 1; u < v; u++)
//         result[u] = -1;  // no color is assigned to u

//     // A temporary array to store the available colors. True
//     // value of available[cr] would mean that the color cr is
//     // assigned to one of its adjacent vertices
//     List<bool> available = new List(v);
//     for (int cr = 0; cr < v; cr++)
//         available[cr] = false;

//     // Assign colors to remaining V-1 vertices
//     for (int u = 1; u < v; u++)
//     {
//         // Process all adjacent vertices and flag their colors
//         // as unavailable
//         int i;

//         for (i = 0; i != adj[u].length; ++i)
//             if (result[adj[u][i]] != -1)
//                 available[result[adj[u][i]]] = true;

//         // Find the first available color
//         int cr;
//         for (cr = 0; cr < v; cr++)
//             if (available[cr] == false)
//                 break;

//         result[u] = cr; // Assign the found color

//         // Reset the values back to false for the next iteration
//         for (i = 0; i != adj[u].length; ++i)
//             if (result[adj[u][i]] != -1)
//                 available[result[adj[u][i]]] = false;

//     }

//     // print the result
//     for (int u = 0; u < V; u++)
//         cout << "Vertex " << u << " --->  Color "
//              << result[u] << endl;
// }

// }
