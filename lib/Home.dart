import 'package:examlogin/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'change.dart';
import 'forgate.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String uname='';
  Future<void>getdata()async{
final SharedPreferences prefs=await SharedPreferences.getInstance();
var getuname=await prefs.getString('uname');

setState(() {
  uname=getuname.toString();
});
  }
  Future<void>removedata()async{
    final SharedPreferences prefs=await SharedPreferences.getInstance();
    var getuname=await prefs.remove('uname');

    setState(() {
      uname=getuname.toString();
    });
  }
  @override
  void initState(){
super.initState();
getdata();
  }
  Widget build(BuildContext context) {
    return Scaffold(appBar:AppBar(backgroundColor:Colors.purple.shade300,title: Text('yeh! successfully login'),
          actions:[Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(style:ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.blueGrey),shape: MaterialStateProperty.all(StadiumBorder()),),onPressed: (){
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginpage()));
removedata();
            } ,child: Text('Logout')),
          ),]
    ),
      body: Center(child: Column(
      children: [

        SizedBox(height:400,),
        Text('welcome',style: TextStyle(fontSize:25 ,color: Colors.purple.shade300),),
        Text(uname!,style: TextStyle(fontSize: 20,color: Colors.purple.shade300),),
        SizedBox(height: 200,),
        Row(
          children: [
            /*Padding(
              padding: const EdgeInsets.only(left: 15),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.purple.shade500)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => loginpage()));
                  },
                  child: Text('login')),
            ),*/
            Padding(
              padding: const EdgeInsets.only(left: 130),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.purple.shade500)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => change()));
                  },
                  child: Text('change password')),
            ),
          ],
        )
      ],
    )),);
  }
}
