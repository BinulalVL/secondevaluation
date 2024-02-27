import 'package:flutter/material.dart';
import 'package:secondevaluation/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstPage extends StatefulWidget {
  FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  @override
  void initState() {
    getStringValuesSF();
    // TODO: implement initState
    super.initState();
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
     setState(() {
       username = prefs.getString('name');
     });
    // return username;
  }


  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("name");
    prefs.remove("password");
    prefs.remove("email");
  }


  var username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome $username'),
      actions: [
        PopupMenuButton(itemBuilder: (context) => [
          PopupMenuItem(child: Row(children:[
            Icon(Icons.logout),
            SizedBox(width: 10,),
            TextButton(onPressed: () {

              Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
          return HomePage();
          },));
              removeValues();
              },
        child: Text('Logout'))],
        )),])
      ],),
      body: Column(
        children: [

        ],
      ),

    );
  }
}
