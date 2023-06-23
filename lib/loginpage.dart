import 'package:examlogin/registerform.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'Home.dart';
import 'dart:convert';
import 'package:get/get.dart';

import 'forgate.dart';


class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController uname = TextEditingController();
  TextEditingController pass = TextEditingController();
  final keys = GlobalKey<FormState>();
  var secure = true;

  void Loginuser() async {
//     if(uname.text=='ankita'&& pass.text=='123'){
// final SharedPreferences prefs=await SharedPreferences.getInstance();
// prefs.setString('uname',uname.text.toString() );
// prefs.setString('pass', pass.text.toString());
// Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
//     }else{
//       print('invalid Username or Password');
//     }
  }

  Future<void> autologin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var getuname = await prefs.getString('uname');
    if (getuname != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    }
  }

  @override
  void initState() {
    super.initState();
    autologin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
          child: Form(
            key: keys,
            child: Column(
              children: [Container(
                height: MediaQuery.of(context).size.height/2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/image/user.jpg"))),),

                //SizedBox(height: 430, width: 400,),
                Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.normal,
                      color: Colors.purple.shade500),
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
                          borderSide:
                              BorderSide(width: 1, color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.purple.shade500)),
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
                    }else if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)){
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
                        borderSide: BorderSide(width: 1, color: Colors.purple.shade500)),
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
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 200),
                  child: TextButton(onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => forgate()));
                  }, child: Text('forgate password',style: TextStyle(color: Colors.purple.shade500,fontSize: 15),)),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.purple.shade500)),
                    onPressed: () async {
                      if (keys.currentState!.validate()) {
                        var formdata = {
                          'uname': uname.text,
                          'pass': pass.text,
                        };
                        //print(jsonEncode(formdata));
                        var response = await http.post(
                            Uri.parse(
                                'https://ntce.000webhostapp.com/login.php'),
                            body: jsonEncode(formdata));
                        if (response.statusCode == 200) {
                          var data = await jsonDecode(response.body);

                          if (data['status'] == 1) {
                            Get.defaultDialog(
                                title: 'login succesfully',
                                middleText: '',
                                backgroundColor: Colors.purple,
                                titleStyle: TextStyle(color: Colors.white),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));

                                }, child:Text('Ok',style: TextStyle(color: Colors.white,fontSize: 20),))
                              ]
                            );


                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('uname', uname.text.toString());
                            prefs.setString('pass', pass.text.toString());

                            // Future.delayed(Duration(seconds: 10),
                            //     await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()))
                            //
                            // );


                          }else{
                            Get.defaultDialog(title: 'Error in signin',
                                middleText: 'Try again',
                                backgroundColor: Colors.redAccent,
                                titleStyle: TextStyle(color: Colors.white)
                            );
                          }
                        }
                      }

                      if (keys.currentState!.validate()) {
                        Loginuser();

                      }

                    },
                    child: Text('signin')),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.purple.shade500)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => registerform()));
                    },
                    child: Text('Register now')),
               /* */
              ],
            ),
          ),
    ));
  }
}
