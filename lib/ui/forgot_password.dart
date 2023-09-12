import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasepract/widgets/round_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/uitilities.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _forgotController=TextEditingController();
  final _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password "),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _forgotController,
              decoration: const InputDecoration(
                hintText: "enter your email",
                border:OutlineInputBorder(

                ),
              ),
            ),
            SizedBox(height: 20,),
            RoundButton(text: "Send password", colour: Colors.deepPurple, onPressed: (){
              _auth.sendPasswordResetEmail(email: _forgotController.text.toString()).then((value){
                Utils().toastMessage("we sent you password on email");
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());
              });
            })
          ],
        ),
      ),
    );
  }
}
