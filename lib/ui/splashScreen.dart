import 'package:firebasepract/firbase_services/splach_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splash=SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splash.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Welcome to Firebase',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
    );
  }
}
