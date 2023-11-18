import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latihan_pertemuan5/main.dart';
import 'package:http/http.dart' as http;

class Edit extends StatefulWidget {
  final List list;
  final int index;
  Edit({Key? key, required this.list, required this.index}) : super(key: key);
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  late TextEditingController name;
  late TextEditingController address;
  late TextEditingController salary;

  void editData() {
    var url = Uri.parse(
        'http://192.168.1.9/restapi2/update.php'); //update api calling
    http.post(url, body: {
      'id': widget.list[widget.index]['id'],
      'name': name.text,
      'address': address.text,
      'salary': salary.text
    });
  }

  @override
  void initState() {
    name = TextEditingController(
        text: widget.list[widget.index]
            ['name']); //setting up the existing values in textediting control
    address = TextEditingController(text: widget.list[widget.index]['address']);
    salary = TextEditingController(text: widget.list[widget.index]['salary']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Edit Data ${widget.list[widget.index]['name']}"),
        ),
        shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: name,
              autofocus: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Name',
                hintText: 'Enter Name',
                // prefixIcon: IconButton(
                //   onPressed: null,
                //   icon: Icon(Icons.title),
                // ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              maxLines: 5,
              controller: address,
              autofocus: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Address',
                hintText: 'Enter Address',
                prefixIcon: IconButton(
                  onPressed: null,
                  icon: Icon(Icons.house_outlined),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              maxLines: 5,
              controller: salary,
              autofocus: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Salary',
                hintText: 'Enter Salary',
                prefixIcon: IconButton(
                  onPressed: null,
                  icon: Icon(Icons.money),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: MaterialButton(
              child: const Text("Edit Data"),
              color: Colors.amber,
              onPressed: () {
                editData();
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => const Home()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
