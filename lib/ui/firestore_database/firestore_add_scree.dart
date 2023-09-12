import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/uitilities.dart';
import '../../widgets/round_widgets.dart';

class FireStoreAddScreen extends StatefulWidget {
  const FireStoreAddScreen({super.key});

  @override
  State<FireStoreAddScreen> createState() => _FireStoreAddScreenState();
}

class _FireStoreAddScreenState extends State<FireStoreAddScreen> {
  bool loading=false;
  final nameController=TextEditingController();
  final _titleController=TextEditingController();
  final fireStore=FirebaseFirestore.instance.collection('student');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add FireStore Data "),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            const SizedBox(height: 70,),
            TextFormField(
              controller: nameController,
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
            fireStore.doc(id).set({
              "id":id,
              "name":nameController.text.toString(),
              "title":_titleController.text.toString()

            }).then((value){
              setState(() {
                loading=false;
              });
            }).onError((error, stackTrace){
              setState(() {
                Utils().toastMessage("added");
                loading=false;
              });
              Utils().toastMessage(error.toString());
            });
            })
          ],
        ),
      ),
    );
  }
}
