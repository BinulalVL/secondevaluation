import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';

class SignPage extends StatelessWidget {
   SignPage({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var email;
  var password;

  Future<void>SignIn(String email,String password)async{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    }
    catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                if(emailController.text=="" || passwordController.text=="" || passwordController.text.length<6){
                  showDialog(context: context, builder: (context) {
                    return
                      AlertDialog(title: Text('Warning'),
                        content: Text("Email can't be empty and password can't be less than 6"),);
                  },);
                }else {
                  email=emailController.text;
                  password=passwordController.text;
                  SignIn(email, password);
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return HomePage();
                    },));


                }},
              child: Text('SignUp')),


        ],
      ),

    );
  }
}
