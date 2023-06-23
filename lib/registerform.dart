import 'package:examlogin/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class registerform extends StatefulWidget {
  const registerform({Key? key}) : super(key: key);

  @override
  State<registerform> createState() => _registerformState();
}

class _registerformState extends State<registerform> {
  TextEditingController email = TextEditingController();
  TextEditingController mob = TextEditingController();
  TextEditingController uname = TextEditingController();
  TextEditingController pass = TextEditingController();
  var secure = true;
  bool valuefirst = false;
  final keys = GlobalKey<FormState>();

  Future<void> submitform() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
          child: Form(
            key: keys,
            child: Column(children: [
              //SizedBox(height: 40,width:300,),
              //ssText('Register Here',style: TextStyle(fontSize: 30,fontStyle: FontStyle.normal,color: Colors.amber),),
              Container(
                height: MediaQuery.of(context).size.height/2,
                width: MediaQuery.of(context).size.width/0.9,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/image/re.jpg"))),),
              /*SizedBox(
                height: 450,
              ),*/
              TextFormField(
                controller: email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'email is required';
                  } else if (!value.contains('@')) {
                    return 'please enter a valid emaiil ';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Email Adress',
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(width: 1, color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                            width: 1, color: Colors.purple.shade500)),
                    prefixIcon: Icon(Icons.mail)),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: mob,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'mobile number is required';
                  } else if (value.length != 10) {
                    return 'please enter a valid mobile number';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Mobile Number',
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(width: 1, color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                            width: 1, color: Colors.purple.shade500)),
                    prefixIcon: Icon(Icons.call)),
              ),
              SizedBox(
                height: 10,
              ),
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
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(width: 1, color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                            width: 1, color: Colors.purple.shade500)),
                    prefixIcon: Icon(Icons.person)),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: pass,
                obscureText: secure,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'password is required';
                  } else if (!RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                      .hasMatch(value)) {
                    return 'please enter a valid password ';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(width: 1, color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide:
                          BorderSide(width: 1, color: Colors.purple.shade500)),
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
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 100,
                  ),
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.purple.shade500,
                    value: this.valuefirst,
                    onChanged: (bool? value) {
                      print(value);
                      setState(() {
                        this.valuefirst = value!;
                      });
                    },
                  ),
                  Text('I Agree to the terms')
                ],
              ),
              IgnorePointer(
                ignoring: !valuefirst,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.purple.shade500)),
                    onPressed: () async {
                      if (keys.currentState!.validate()) {
                        var formdata = {
                          'uname': uname.text,
                          'pass': pass.text,
                          'mob': mob.text,
                          'email': email.text
                        };
                        //print(jsonEncode(formdata));
                        var response = await http.post(
                            Uri.parse('https://ntce.000webhostapp.com/api.php'),
                            body: jsonEncode(formdata));
                        if (response.statusCode == 200) {
                          var data = await jsonDecode(response.body);
                          print(data);
                          if (data['status'] == 1) {
                            Get.defaultDialog(
                                title: 'Registration completed succesfully',
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
                          } else {
                            Get.defaultDialog(
                                title: 'Error in Registration',
                                middleText: 'Try again',
                                backgroundColor: Colors.redAccent,
                                titleStyle: TextStyle(color: Colors.white));
                          }
                        }
                      }
                    },
                    child: Text('Register')),
              ),
            ]),
          ),

      ),
    );
  }
}
