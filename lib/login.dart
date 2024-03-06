import 'package:flutter/material.dart';
import 'package:sqlliteex/register.dart';
import 'package:sqlliteex/sqldatabase.dart';
import 'package:sqlliteex/userhome.dart';

import 'adminhome.dart';

class myLogin extends StatefulWidget{
  @override
  State<myLogin> createState() => _myLoginState();
}

class _myLoginState extends State<myLogin> {
  var formkey = GlobalKey<FormState>();
  //GlobalKey<FormState>formkey=GlobalKey();
  @override

  final  conemail = TextEditingController();
  final  conpass = TextEditingController();
  bool txt=true;

  Widget build(BuildContext context) {
    void logincheck(String email, String password) async {
      if(email == 'admin@gmail.com' && password == '123456') {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> adminHome()));
      }else{
        var data = await Sqlhelper.CheckLogin(email,password);
        if(data.isNotEmpty){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> userHome(data: data,)));
        }
        else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>myRegister()));
        }
      }
    }
    return Scaffold(
      body: Container(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Icon(Icons.person),
              TextFormField(
                validator: (email){
                  if(email!.isEmpty&&!email.contains('@')&&!email.contains('.')){
                    return "Enter valid email id";
                  }
                },
                controller: conemail,
                decoration: InputDecoration(
                    labelText: 'username',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
                ),
              ),
              TextFormField(
                validator: (pass){
                  if(pass!.isEmpty&&pass.length>6){
                    return "Enter valid password";
                  }
                },
                controller: conpass,
                decoration: InputDecoration(
                    labelText: 'password',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
                ),
              ),
              ElevatedButton(onPressed: () async {
                final valid=formkey.currentState!.validate();
                if(valid){
                  logincheck(conemail.text, conpass.text);
                }
              },
                  child: Text("Login")),
              ElevatedButton(onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> myRegister()));
              },
                  child: Text("Register")),
            ],
          ),
        ),
      ),
    );
  }
}