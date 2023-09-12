import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasepract/ui/posts/posts_screen.dart';
import 'package:firebasepract/utils/uitilities.dart';
import 'package:firebasepract/widgets/round_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VarificationNumberScreen extends StatefulWidget {
  final String varification;
   VarificationNumberScreen({super.key,required this.varification});

  @override
  State<VarificationNumberScreen> createState() => _VarificationNumberScreenState();
}

class _VarificationNumberScreenState extends State<VarificationNumberScreen> {
     bool loading=false;
  final _varificationController=TextEditingController();
  final _auth = FirebaseAuth.instance;


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
              keyboardType: TextInputType.number,
              controller: _varificationController,
              decoration: InputDecoration(
                  hintText: "  ",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide())),

            ),
            SizedBox(
              height: 60,
            ),
            RoundButton(text: "Verify", loading:loading,colour: Colors.deepPurple, onPressed: ()async{


            final credential=PhoneAuthProvider.credential(verificationId: widget.varification, smsCode:_varificationController.text.toString());
            setState(() {
              loading=true;
            });
            try
                {

                 await  _auth.signInWithCredential(credential);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));
                }
                catch(e)
              {
                setState(() {
                  loading=false;
                });
                Utils().toastMessage(e.toString());
              }

            })
          ],
        ),
      ),
    );
  }
}
