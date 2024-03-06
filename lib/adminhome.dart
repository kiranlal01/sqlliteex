

import 'package:flutter/material.dart';
import 'package:sqlliteex/sqldatabase.dart';

import 'additem.dart';

class adminHome extends StatefulWidget{
  @override
  State<adminHome> createState() => _adminHomeState();
}

class _adminHomeState extends State<adminHome> {
  var data;
  void delet(int id) async {
    await Sqlhelper.Deleteuser(id);
    Refresh();
  }
  @override
  void initState() {
    Refresh();
    super.initState();
  }
  void Refresh() async {
    var mydata = await Sqlhelper.getAll();
    setState(() {
      data = mydata;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(itemBuilder: (context,int index){
                return Card(
                  color: Colors.deepPurple[200],
                  child: ListTile(
                    title: Text('${data[index]['name']}'),
                    trailing: IconButton(onPressed: () {
                      delet(data[index]['id']);
                    }, icon: Icon(Icons.delete)),
                  ),
                );
              },itemCount: data.length,),
              ElevatedButton.icon(onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddItem()));
              } , icon: Icon(Icons.add), label: Text("Add"))
            ],
          ),
        )
    );
  }
}