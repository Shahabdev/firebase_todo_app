import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  String text;
  Color colour;
  final VoidCallback onPressed;
  final bool loading;
   RoundButton({super.key,required this.text,required this.colour,
     required this.onPressed,
   this.loading=false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 55,

        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(15)

        ),
        child: Center(child:loading? CircularProgressIndicator(strokeWidth: 3,color: Colors.white,):Text(text,style: const TextStyle(fontSize: 28,color: Colors.white),)),

      ),
    );
  }
}
