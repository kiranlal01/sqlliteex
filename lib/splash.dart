import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqlliteex/register.dart';

void main(){
  runApp(MaterialApp(home: Splashdata(),debugShowCheckedModeBanner: false,));
}

class Splashdata extends StatefulWidget{

  @override
  State<Splashdata> createState() => _SplashdataState();
}

class _SplashdataState extends State<Splashdata> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>myRegister()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}