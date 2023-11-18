import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'details.dart';
import 'newdata.dart';

void main() => runApp(MaterialApp(
      title: "Latihan Pertemuan 5",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const Home(),
    ));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Map<String, dynamic>>> getData() async {
    var url = Uri.parse('http://192.168.1.9/restapi2/list.php');
    final response = await http.post(url);
    return List<Map<String, dynamic>>.from(jsonDecode(response.body));
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("MyAplikasi"),
        ),
        shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext contex) => NewData(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getData(),
        builder: (ctx, ss) {
          if (ss.hasError) {
            print("error");
          }
          if (ss.hasData) {
            return Items(list: ss.data!);
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class Items extends StatelessWidget {
  final List list;

  Items({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (ctx, i) {
        return Container(
          margin: const EdgeInsets.all(7.0), // Atur margin
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0), // Atur radius border
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(1), // Warna shadow
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 2), // Offset shadow
              ),
            ],
          ),
          child: ListTile(
            title: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {
                0: FractionColumnWidth(0.1),
                1: FractionColumnWidth(0.1),
                2: FractionColumnWidth(0.5),
              },
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Name',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        ':',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          list[i]['name']
                              .split(' ')
                              .map((String word) =>
                                  word[0].toUpperCase() + word.substring(1))
                              .join(' '),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Address',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        ':',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          list[i]['address'],
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Salary',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        ':',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _formatCurrency(list[i]['salary']),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            leading: CircleAvatar(
              child: Text(
                  (i + 1).toString()), // Mengganti ikon dengan angka urutan
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            dense: true,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => Details(list: list, index: i),
            )),
          ),
        );
      },
    );
  }
}

String _formatCurrency(dynamic amount) {
  if (amount is int) {
    return 'Rp ${amount.toString().replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match match) => '${match[1]},',
            )}'
        .trim();
  } else if (amount is String) {
    int intValue = int.tryParse(amount) ?? 0;
    return 'Rp ${intValue.toString().replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match match) => '${match[1]},',
            )}'
        .trim();
  } else {
    return 'Rp 0';
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'details.dart';
// import 'adddata.dart';

// void main() => runApp(MaterialApp(
//       title: "Aplikasi Saya",
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.teal,
//       ),
//       home: const Home(),
//     ));

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   Future<List> getData() async {
//     var url =
//         Uri.parse('http://192.168.43.236/restapi_crud/list.php'); //Api Link
//     final response = await http.post(url);
//     return jsonDecode(response.body);
//   }

//   @override
//   void initState() {
//     getData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Center(
//           child: Text("PHP MySQL CRUD | Ega Permana"),
//         ),
//         shape: const ContinuousRectangleBorder(
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(50),
//             bottomRight: Radius.circular(50),
//           ),
//         ),
//         automaticallyImplyLeading: false, // Hapus ikon "arrow left"
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (BuildContext contex) => NewData(),
//           ),
//         ),
//         child: const Icon(Icons.add),
//       ),
//       body: FutureBuilder<List>(
//         future: getData(),
//         builder: (ctx, ss) {
//           if (ss.connectionState == ConnectionState.waiting) {
//             // Jika masih dalam proses loading, tampilkan CircularProgressIndicator di tengah layar.
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (ss.hasError) {
//             // Jika terjadi kesalahan, tampilkan pesan kesalahan.
//             return Text('Error: ${ss.error}');
//           } else if (ss.hasData) {
//             // Jika data tersedia, tampilkan daftar item.
//             return Items(list: ss.data!);
//           } else {
//             // Jika tidak ada data, tampilkan pesan lain atau widget kosong.
//             return Text('No Data');
//           }
//         },
//       ),
//     );
//   }
// }

// class Items extends StatelessWidget {
//   final List list;

//   Items({Key? key, required this.list}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: list.length,
//       itemBuilder: (ctx, i) {
//         return Container(
//           margin: const EdgeInsets.all(7.0), // Atur margin
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12.0), // Atur radius border
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.white.withOpacity(1), // Warna shadow
//                 spreadRadius: 1,
//                 blurRadius: 1,
//                 offset: const Offset(0, 2), // Offset shadow
//               ),
//             ],
//           ),
//           child: ListTile(
//             title: Table(
//               defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//               columnWidths: {
//                 0: FractionColumnWidth(0.1),
//                 1: FractionColumnWidth(0.1),
//                 2: FractionColumnWidth(0.5),
//               },
//               children: [
//                 TableRow(
//                   children: [
//                     TableCell(
//                       child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           'Nama',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                     TableCell(
//                       child: Text(
//                         ':',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     TableCell(
//                       child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           list[i]['name']
//                               .split(' ')
//                               .map((String word) =>
//                                   word[0].toUpperCase() + word.substring(1))
//                               .join(' '),
//                           textAlign: TextAlign.left,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 TableRow(
//                   children: [
//                     TableCell(
//                       child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           'Alamat',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                     TableCell(
//                       child: Text(
//                         ':',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     TableCell(
//                       child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           list[i]['address'],
//                           textAlign: TextAlign.left,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 TableRow(
//                   children: [
//                     TableCell(
//                       child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           'Gaji',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                     TableCell(
//                       child: Text(
//                         ':',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     TableCell(
//                       child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           _formatCurrency(list[i]['salary']),
//                           textAlign: TextAlign.left,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             leading: CircleAvatar(
//               child: Text(
//                   (i + 1).toString()), // Mengganti ikon dengan angka urutan
//             ),
//             contentPadding:
//                 EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
//             dense: true,
//             onTap: () => Navigator.of(context).push(MaterialPageRoute(
//               builder: (BuildContext context) => Details(list: list, index: i),
//             )),
//           ),
//         );
//       },
//     );
//   }
// }

// String _formatCurrency(dynamic amount) {
//   if (amount is int) {
//     return 'Rp ${amount.toString().replaceAllMapped(
//               RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
//               (Match match) => '${match[1]},',
//             )}'
//         .trim();
//   } else if (amount is String) {
//     int intValue = int.tryParse(amount) ?? 0;
//     return 'Rp ${intValue.toString().replaceAllMapped(
//               RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
//               (Match match) => '${match[1]},',
//             )}'
//         .trim();
//   } else {
//     return 'Rp 0';
//   }
// }