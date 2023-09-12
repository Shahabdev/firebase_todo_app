import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasepract/ui/auth/varification_phone_screen.dart';
import 'package:firebasepract/utils/uitilities.dart';
import 'package:firebasepract/widgets/round_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  final _numberController=TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool loading=false;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
          const  SizedBox(
              height: 120,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _numberController,
              decoration: InputDecoration(
                  hintText: "+92 331 9945231",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide())),

            ),
            SizedBox(
              height: 60,
            ),
            RoundButton(text: "Login",loading: loading, colour: Colors.deepPurple, onPressed: (){
              setState(() {
                loading=true;
              });
              _auth.verifyPhoneNumber(
                  phoneNumber: _numberController.text.toString(),
                    verificationCompleted: (_){
                      setState(() {
                        loading=false;
                      });

                    },
                    verificationFailed: (e){
                      setState(() {
                        loading=false;
                      });
                      Utils().toastMessage(e.toString());

                   },
                    codeSent: (String verificationId,int? token )
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>VarificationNumberScreen(varification: verificationId)));
                      setState(() {
                        loading=false;
                      });
                    },
                    codeAutoRetrievalTimeout: (e){
                      setState(() {
                        loading=false;
                      });
                      Utils().toastMessage(e.toString());
                    });
            })
          ],
        ),
      ),
    );
  }
}
