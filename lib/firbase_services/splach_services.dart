import 'dart:async';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasepract/ui/auth/loginScreen.dart';
import 'package:firebasepract/ui/firestore_database/firestore_list_data.dart';
import 'package:firebasepract/ui/image_upload_screen.dart';
import 'package:flutter/material.dart';

import '../ui/posts/posts_screen.dart';

class SplashServices
{
  void isLogin(BuildContext context)
  {
    final auth=FirebaseAuth.instance;
    final user=auth.currentUser;
    if(user!=null)
      {
        Timer(Duration(seconds: 3),()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageUploadScreen())));
      //  Timer(Duration(seconds: 3),()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>FireStoreListScreen())));

        //Timer(Duration(seconds: 3),()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen())));
      }
    else
      {
        Timer(Duration(seconds: 3),()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen())));
      }

  }
}