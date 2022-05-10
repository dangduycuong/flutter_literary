// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
//
// import 'package:csv/csv.dart';
//
// class HomePageScreen extends StatefulWidget {
//   const HomePageScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomePageScreen> createState() => _HomePageScreenState();
// }
//
// class _HomePageScreenState extends State<HomePageScreen> {
//   List<List<dynamic>> _data = [];
//   String data2 = '';
//   List<String> _contentList = [];
//
//   // This function is triggered when the floating button is pressed
//   void _loadCSV() async {
//     final _rawData = await rootBundle.loadString("resources/folk_verses/folk_verses.csv");
//
//     _contentList = _rawData.split('*');
//     setState(() {
//       data2 = _rawData;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Kindacode.com"),
//       ),
//       // Display the contents from the CSV file
//       body: ListView.builder(
//         itemCount: _contentList.length,
//         itemBuilder:  (context, index) {
//           return Card(
//             margin: const EdgeInsets.all(3),
//             color: Colors.white,
//             child: Text(_contentList[index]),
//           );
//         }
//       ),
//
//       floatingActionButton: FloatingActionButton(
//           child: const Icon(Icons.add), onPressed: _loadCSV),
//     );
//   }
// }
