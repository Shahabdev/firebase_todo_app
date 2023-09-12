import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebasepract/widgets/round_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/uitilities.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {

  bool loading=false;
  final _addController=TextEditingController();
  final _titleController=TextEditingController();

  final databaseReference=FirebaseDatabase.instance.ref("student");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            const SizedBox(height: 70,),
            TextFormField(
              controller: _addController,
              maxLines: 4,
              decoration:const  InputDecoration(
                hintText: "ENTER Student name",
                border:OutlineInputBorder(
                  borderSide: BorderSide()
                )
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: _titleController,

              decoration:const  InputDecoration(
                  hintText: "Enter the degree tittle",
                  border:OutlineInputBorder(
                      borderSide: BorderSide()
                  )
              ),
            ),
            SizedBox(height: 20,),
            RoundButton(text: "Add",loading: loading, colour:Colors.deepPurple, onPressed: (){
              setState(() {
                loading=true;
              });
                 String id=DateTime.now().millisecondsSinceEpoch.toString();
                databaseReference.child(id).set({
                   "id":id,
                  "name":_addController.text.toString(),
                  "title":_titleController.text.toString(),
                }).then((value) {
                  setState(() {
                    loading=false;
                  });
                  Utils().toastMessage("post added");

                }).onError((error, stackTrace) {
                  setState(() {
                    loading=false;
                  });
                  Utils().toastMessage(error.toString());
                  debugPrint("shahab -------/${error.toString()}");
                });
            })
          ],
        ),
      ),
    );
  }
}
