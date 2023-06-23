import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:examlogin/loginpage.dart';

class change extends StatefulWidget {
  const change({Key? key}) : super(key: key);

  @override
  State<change> createState() => _changeState();
}

class _changeState extends State<change> {
  TextEditingController npass=TextEditingController();
  TextEditingController cpass=TextEditingController();
  TextEditingController opass=TextEditingController();
  TextEditingController uname=TextEditingController();
  final keys = GlobalKey<FormState>();
  var secure=true;
  var old=true ;
  var change=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: true,
      body:

    SingleChildScrollView(scrollDirection: Axis.vertical,

      child: Form(key: keys,
        child: Column(
          children: [Container(
          height:350,
         // width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/image/45.png")))),
            Center(
              child: Container(height:MediaQuery.of(context).size.height/1.5,width: MediaQuery.of(context).size.width/1.2,
               // decoration:BoxDecoration(border: Border.all(color: Colors.purple.shade500,width: 2)) ,
                child: Column(
                  children: [Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text('Genrate New Password',style: TextStyle(fontSize: 30),),
                    ),
                    SizedBox(height: 30,),
                    TextFormField(
                      controller: uname,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'uname is required';
                        }
                      },
                      decoration: InputDecoration(
                          hintText: 'Username',
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.zero),
                              borderSide:
                              BorderSide(width: 1, color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.zero),
                              borderSide:
                              BorderSide(width: 1, color: Colors.purple.shade500)),
                          prefixIcon: Icon(Icons.person)),
                    ),
                    SizedBox(height: 25,),
                    TextFormField(controller: opass,
                      obscureText: old,
                      validator: (value){
                        if(value==null||value.isEmpty){
                          return 'password is required';
                        }else if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)){
    return 'please enter a valid password ';
                      }},
                      decoration: InputDecoration(
                          hintText: 'Old passwod',
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.zero),
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.zero),
                              borderSide:BorderSide(color: Colors.purple.shade500) ),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                old = !old;
                              });
                            },
                            icon: old == true
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility)),

                      ),
                    ),
                    SizedBox(height: 25,),
                    TextFormField(controller: npass,
                      obscureText: secure,
                      validator: (value){
                        if(value==null||value.isEmpty){
                          return 'New password is required';

                        }else if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)){
                          return 'please enter a valid password ';
                        }

                        if(value.toString()!=cpass.text){
                          return 'pass is not match';
                        }

                        return null;
                      },
                      decoration: InputDecoration(hintText: 'New password',
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.zero),
                              borderSide:BorderSide(color: Colors.black) ),
                          focusedBorder:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.zero),
                              borderSide:BorderSide(color: Colors.purple.shade500) ),
                          prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              secure = !secure;
                            });
                          },
                          icon: secure == true
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility)),

                    ),
                    ),
                    SizedBox(height: 25,),
                    TextFormField(controller: cpass,
                      obscureText: change,
                      validator: (value){
                        if(value==null||value.isEmpty){
                          return 'confirm password is required';
                        }else if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)){
                          return 'please enter a valid password ';
                        }
                        if(value.toString()!=npass.text){
                          return 'password is not match';
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintText:'Confirm password',
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.zero),
                              borderSide:BorderSide(color: Colors.black) ),
                          focusedBorder:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.zero),
                              borderSide:BorderSide(color: Colors.purple.shade500) ) ,
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                change = !change;
                              });
                            },
                            icon: change == true
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility)),

                      ),),
                    SizedBox(height: 30,),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.purple.shade500)),
                        onPressed: () async{
                          if (keys.currentState!.validate()){
                            var formdata = {
                              'uname':uname.text,
                              'opass': opass.text,
                              'npass': npass.text,
                              'cpass': cpass.text,

                            };
                            print(jsonEncode(formdata));
                            var response = await http.post(
                                Uri.parse('https://ntce.000webhostapp.com/change.php'),
                                body: jsonEncode(formdata));
                            if (response.statusCode == 200) {
                              var data = await jsonDecode(response.body);
                              print(data);
                              if (data['status'] == 1) {
                                Get.defaultDialog(
                                    title: 'Change password succesfully',
                                    middleText: '',
                                    actions: [
                                      CircleAvatar(
                                        child: IconButton(onPressed:(){
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (contex)=>loginpage())) ;
                                        },
                                          icon:Icon(Icons.check),
                                          color: Colors.purple.shade500,
                                        ),
                                        backgroundColor: Colors.white,
                                      )
                                    ],
                                    backgroundColor: Colors.purple.shade500,
                                    titleStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                    radius: 30);

                                //var data = await jsonDecode(response.body);
                                //print(data);
                                //print(response.body);
                              }
                            }

                          }
                        },
                        child: Text('Change password'))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),);
  }
}
