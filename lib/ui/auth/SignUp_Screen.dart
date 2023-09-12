import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasepract/ui/auth/loginScreen.dart';
import 'package:firebasepract/utils/uitilities.dart';
import 'package:firebasepract/widgets/round_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading=false;
  FirebaseAuth _auth=FirebaseAuth.instance;
  final _formKey=GlobalKey<FormState>();
  final _emailController=TextEditingController();
  final _passwardController=TextEditingController();
  void signUp()
  {
    if(_formKey.currentState!.validate())
    {
      setState(() {
        loading=true;
      });

      _auth.createUserWithEmailAndPassword(
        email: _emailController.text.toString(),
        password: _passwardController.text.toString(),

      ).then((value) {
        setState(() {
          // Utils().toastMessage(value.toString());
          loading=false;
        });
      } ).onError((error, stackTrace){

        setState(() {
          Utils().toastMessage(error.toString());
          loading=false;
        });


      });
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwardController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign up Screen",
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30,right:30,top: 200),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child:Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: InputDecoration(
                          hintText: "email",
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(

                              )

                          )
                      ),
                      validator: (value){
                        // final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        // if(value!.isEmpty)
                        //   {
                        //     return "enter email";
                        //   }
                        // if(emailRegex.hasMatch(value))
                        //   {
                        //     return "enter valid email";
                        //   }
                        const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                            r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                            r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                            r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                            r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                            r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                            r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
                        final regex = RegExp(pattern);

                        return value!.isNotEmpty && !regex.hasMatch(value)
                            ? 'Enter a valid email address'
                            : null;
                      },
                    ),
                    SizedBox(height: 29,),
                    TextFormField(

                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      controller:_passwardController,
                      decoration: InputDecoration(
                          hintText: "password",
                          prefixIcon: Icon(Icons.password),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),

                          )
                      ),
                      validator: (value)
                      {
                        //   const pattern=r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                        //   final regex=RegExp(pattern);
                        // return  value!.isNotEmpty && !regex.hasMatch(value)
                        //   ? "enter valid password":null;

                        if(value!.isEmpty)
                        {
                          return "enter password";
                        }
                        else
                        {
                          return null;
                        }
                      },
                    ),
                  ],
                ) ,),

              SizedBox(height: 45,),
              RoundButton(

                loading: loading,
                  text: "Sign up", colour: Colors.deepPurple, onPressed: () {
                signUp();
              }),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account ?",style: TextStyle(fontSize: 20),),
                  TextButton(onPressed: ()
                  {

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  }, child: Text('login',style: TextStyle(fontSize: 25)))
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
