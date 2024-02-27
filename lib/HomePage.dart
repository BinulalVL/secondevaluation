import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:secondevaluation/FirstPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SigninPage.dart';
class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController unameController = TextEditingController();

  var email;
  var username;
  var password;

 sharedPref(String username,String email,String password)async{
    final prefs = await SharedPreferences.getInstance();
prefs.setString('name', username);
prefs.setString('email', email);
prefs.setString('password', password);
print(prefs.getString('name'));
  }



  @override
  Widget build(BuildContext context) {
    Future<void> LoginUser(String email, String password) async {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return FirstPage();
        },));
      } catch (e) {
        print('Error:$e');
      }
    }
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: unameController,
              decoration: InputDecoration(hintText: 'Username'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(hintText: 'Password'),
            ),
            ElevatedButton(
                onPressed: () {
                  if(unameController.text == "" || emailController.text=="" || passwordController.text==""){
                    showDialog(context: context, builder: (context) {
                      return
                      AlertDialog(title: Text('Warning'),
                      content: Text("Email and Password Can't be empty"),);
                    },);
                  }else {
                    email = emailController.text;
                    password = passwordController.text;
                    username = unameController.text;
                    setState(() {
                      LoginUser(email, password);
                    });
                    sharedPref(username, email, password);
                  }},
                child: Text('Login')),
            TextButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SignPage();
              },));
            }, child: Text('SignUp'))
          ],
        ),
      ),
    );
  }
}
