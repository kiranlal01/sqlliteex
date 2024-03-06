import 'package:flutter/material.dart';
import 'package:sqlliteex/splash.dart';
import 'package:sqlliteex/sqldatabase.dart';

import 'login.dart';



class myRegister extends StatefulWidget{
  @override
  State<myRegister> createState() => _myRegisterState();
}

class _myRegisterState extends State<myRegister> {

  GlobalKey<FormState>fkey = GlobalKey();

  @override

  final name = TextEditingController();
  final email = TextEditingController();
  final pass = TextEditingController();
  final cpass = TextEditingController();

  Widget build(BuildContext context) {
    void addDatabase(String name,String email,String password) async {
      var id = await Sqlhelper.addDatabase(name, email, password);
      if(id!=null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>myLogin()));
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Splashdata()));
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Registration completed")));
    }
    return Scaffold(
      body: Container(
        child: Form(
          key: fkey,
          child: Column(
            children: [
              SizedBox(height: 50),
              TextFormField(
                validator: (name){
                  if(name!.isEmpty){
                    return "Name is required";
                  }
                },
                controller: name,
                decoration: InputDecoration(
                  labelText: 'name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (email){
                  if(email!.isEmpty&&!email.contains('@')&&!email.contains('.')){
                    return "Enter valid email id";
                  }
                },
                controller: email,
                decoration: InputDecoration(
                  labelText: 'email',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (passw){
                  if(passw!.isEmpty&&passw.length>6){
                    return "Enter valid password";
                  }
                },
                controller: pass,
                decoration: InputDecoration(
                    labelText: 'password',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (cpassw){
                  if(cpassw!.isEmpty&&cpassw.length>6){
                    return "password should be length";
                  }
                  else if(pass.text!=cpass.text){
                    return "password ia not match";
                  }
                },
                controller: cpass,
                decoration: InputDecoration(
                  labelText: 'confirm password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(onPressed: () async {
                final valid=fkey.currentState!.validate();
                if(valid){
                  String Uemail=email.text;
                  var data=await Sqlhelper.userFound(Uemail);
                  if(data.isNotEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User already exists...")));
                  }
                  else{
                    addDatabase(name.text, email.text, pass.text);
                  }
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(action: SnackBarAction(label: 'UNDO',onPressed: (){}),
                    content: Text('Invalid username/password'),));
                }
              },
                  child: Text("Register")),
              SizedBox(height: 10),
              ElevatedButton(onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => myLogin()));
              },
                  child: Text("Login")),
            ],
          ),
        ),
      ),
    );
  }


}