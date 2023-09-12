import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebasepract/widgets/round_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../utils/uitilities.dart';

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({super.key});

  @override
  State<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  bool loading=false;
  File? _image;
  final picker = ImagePicker();
  firebase_storage.FirebaseStorage storage=firebase_storage.FirebaseStorage.instance;
  DatabaseReference reference=FirebaseDatabase.instance.ref("student");

  uploadImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        Utils().toastMessage("image is not picked");
      }

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload image on firebase storage"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: (){
                  uploadImage();
                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 10)),
                  child: _image != null
                      ? Image.file(_image!.absolute)
                      : Icon(Icons.photo),
                ),
              ),
            ),
            SizedBox(height: 20,),
            RoundButton(text: "Upload image",loading: loading, colour: Colors.deepPurple, onPressed: (){
              setState(() {
                loading=true;
              });

                // upload image on firebase storage
              firebase_storage.Reference ref=firebase_storage.FirebaseStorage.instance.ref("/shahab/"+DateTime.now().millisecondsSinceEpoch.toString());
              firebase_storage.UploadTask uploadTask=ref.putFile(_image!.absolute);

              //upload image on real time database
              Future.value(uploadTask).then((value) async{
                var newUrl= await ref.getDownloadURL();
                reference.child(DateTime.now().millisecondsSinceEpoch.toString()).set(
                  {

                    "id":DateTime.now().millisecondsSinceEpoch.toString(),
                    "image":newUrl.toString()
                  }
                ).then((value) {
                  setState(() {
                    loading=false;
                  });
                  Utils().toastMessage("uploaded");

                }).onError((error, stackTrace) {
                  setState(() {
                    loading=false;
                  });

                  Utils().toastMessage(error.toString());
                });
              });


            })
          ],
        ),
      ),
    );
  }
}
