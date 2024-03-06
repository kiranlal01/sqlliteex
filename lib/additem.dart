import 'package:flutter/material.dart';
import 'package:sqlliteex/sqldatabase.dart';

class AddItem extends StatefulWidget{
  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final name=TextEditingController();
  final price=TextEditingController();
  final details=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 20,),
            TextField(
              controller: name,
              decoration: InputDecoration(
                  labelText: 'name',
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: price,
              decoration: InputDecoration(
                  labelText: 'price',
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: details,
              decoration: InputDecoration(
                  labelText: 'description',
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: () {
              adminAccess(name.text,price.text,details.text);
            }, child: Text("Add"))
          ],
        ),
      ),
    );
  }

  Future adminAccess(String text1, String text2, String text3) async {
    var id=await Sqlhelper.addItem(text1,text2,text3);
    if(id!=null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Product Added')));
    }
  }
}