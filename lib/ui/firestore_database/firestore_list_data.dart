import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasepract/ui/firestore_database/firestore_add_scree.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/uitilities.dart';
import '../auth/loginScreen.dart';

class FireStoreListScreen extends StatefulWidget {
  const FireStoreListScreen({super.key});

  @override
  State<FireStoreListScreen> createState() => _FireStoreListScreenState();
}

class _FireStoreListScreenState extends State<FireStoreListScreen> {
  final auth=FirebaseAuth.instance;
  final _filterController=TextEditingController();
  final _updateController=TextEditingController();

  final fireStore=FirebaseFirestore.instance.collection("student").snapshots();
  CollectionReference ref=FirebaseFirestore.instance.collection("student");

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [

            IconButton(onPressed: (){
              auth.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
            }, icon:const Icon(Icons.logout) ),
            const  SizedBox(width: 10,),

          ],
          title: const Text("FireStore Data Screen"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              TextFormField(
                  controller: _filterController,
                  decoration: const InputDecoration(
                      hintText: "search",
                      border: OutlineInputBorder()

                  ),
                  onChanged:(String value)
                  {
                    setState(() {

                    });
                  }
              ),
           StreamBuilder<QuerySnapshot>(
             stream: fireStore,
               builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
               {




                 if(snapshot.connectionState==ConnectionState.waiting)
                   {
                     return CircularProgressIndicator();
                   }
                 if(snapshot.hasError)
                   return Text("something went to wrong");


                  return  Expanded(
                  child:ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context,index){
                        final name=snapshot.data!.docs[index]["name"].toString();
                        if(_filterController.text.isEmpty)
                          {
                            return ListTile(
                              title: Text(snapshot.data!.docs[index]["name"].toString()),
                              trailing: PopupMenuButton<String>(
                                itemBuilder: (BuildContext context){
                                  return [
                                    PopupMenuItem(
                                        value: "1",
                                        child:ListTile(
                                          onTap: (){
                                            Navigator.pop(context);
                                            final name=snapshot.data!.docs[index]["name"].toString();
                                            final id=snapshot.data!.docs[index]["id"].toString();
                                            showMyDialog(name, id);

                                          },
                                          title: Text("Update"),
                                          leading:Icon(Icons.edit),)),
                                    PopupMenuItem(
                                        value: "2",
                                        child:ListTile(
                                          onTap:(){
                                            Navigator.pop(context);
                                            final id=snapshot.data!.docs[index]["id"].toString();

                                            ref.doc(id).delete();
                                          },
                                          title: Text("Delete"),
                                          leading:Icon(Icons.delete),)),

                                  ];
                                },
                              ),
                            );
                          }
                        else if(name.toLowerCase().contains(_filterController.text.toLowerCase()))
                          {
                            return ListTile(
                              title: Text(snapshot.data!.docs[index]["name"].toString()),
                              trailing: PopupMenuButton<String>(
                                itemBuilder: (BuildContext context){
                                  return [
                                    PopupMenuItem(
                                        value: "1",
                                        child:ListTile(
                                          onTap: (){
                                            Navigator.pop(context);
                                            final name=snapshot.data!.docs[index]["name"].toString();
                                            final id=snapshot.data!.docs[index]["id"].toString();
                                            showMyDialog(name, id);

                                          },
                                          title: Text("Update"),
                                          leading:Icon(Icons.edit),)),
                                    PopupMenuItem(
                                        value: "2",
                                        child:ListTile(
                                          onTap:(){
                                            Navigator.pop(context);
                                            final id=snapshot.data!.docs[index]["id"].toString();

                                            ref.doc(id).delete();
                                          },
                                          title: Text("Delete"),
                                          leading:Icon(Icons.delete),)),

                                  ];
                                },
                              ),
                            );
                          }
                        else
                          {
                            return Container();
                          }

                      })
              );
           })


            ],

          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){

            Navigator.push(context, MaterialPageRoute(builder: (context)=>FireStoreAddScreen()));
          },
          child: Icon(Icons.add),
        ),

      ),
    );
  }
  Future<void> showMyDialog(String title,String id)async
  {
    _updateController.text=title;

    return showDialog(context: context, builder: (BuildContext context)
    {


      return AlertDialog(
        title: Text("Update"),

        content: Container(
          child: TextFormField(
            controller: _updateController,
            decoration: InputDecoration(
                hintText: "please makes changes here"
            ),

          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("Cancel")),
          TextButton(onPressed: (){
            Navigator.pop(context);
            ref.doc(id).update({
              "name":_updateController.text.toString()
            }).then((value) {
              Utils().toastMessage("updated");

            }).onError((error, stackTrace) {

              Utils().toastMessage(error.toString());
            });

          }, child: Text("Update")),

        ],

      );
    });
  }
}
