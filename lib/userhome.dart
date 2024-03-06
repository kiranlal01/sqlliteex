import 'package:flutter/material.dart';

class userHome extends StatelessWidget{
  final data;
  const userHome({Key? key,required this.data}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    var name = data[0]['name'];
    var email = data[0]['email'];
    return Scaffold(
      appBar: AppBar(title: Text("Welcome $name"),),
      body: Container(
        child: Text("$email"),
      ),
    );
  }

}