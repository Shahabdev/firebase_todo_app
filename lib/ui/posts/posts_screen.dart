import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebasepract/ui/auth/loginScreen.dart';
import 'package:firebasepract/ui/posts/add_post.dart';
import 'package:firebasepract/utils/uitilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final _filterController = TextEditingController();
  final _updateController = TextEditingController();

  final databaseReference = FirebaseDatabase.instance.ref("student");
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  auth.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                icon: const Icon(Icons.logout)),
            const SizedBox(
              width: 10,
            ),
          ],
          title: const Text("Post Screen"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: _filterController,
                  decoration: const InputDecoration(
                      hintText: "search", border: OutlineInputBorder()),
                  onChanged: (String value) {
                    setState(() {});
                  }),
              Expanded(
                child: FirebaseAnimatedList(
                    query: databaseReference,
                    itemBuilder: (context, snapshot, animated, index) {
                      final titl = snapshot.child("name").value.toString();
                      if (_filterController.text.isEmpty) {
                        return ListTile(
                          title: Text(snapshot.child("name").value.toString()),
                          subtitle:
                              Text(snapshot.child("title").value.toString()),
                          trailing: PopupMenuButton<String>(
                              itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem<String>(
                                value: "1",
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    showMyDialog(titl,
                                        snapshot.child("id").value.toString());
                                  },
                                  title: Text("Edit"),
                                  leading: Icon(Icons.edit),
                                ),
                              ),
                              PopupMenuItem<String>(
                                value: "2",
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    databaseReference
                                        .child(snapshot
                                            .child("id")
                                            .value
                                            .toString())
                                        .remove();
                                  },
                                  title: Text("Delete"),
                                  leading: Icon(Icons.delete),
                                ),
                              ),
                            ];
                          }),
                        );
                      } else if (titl
                          .toLowerCase()
                          .contains(_filterController.text.toLowerCase())) {
                        return ListTile(
                          title: Text(snapshot.child("grade").value.toString()),
                          subtitle:
                              Text(snapshot.child("title").value.toString()),
                        );
                      } else {
                        return Container();
                      }
                    }),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddPost()));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    _updateController.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Update"),
            content: Container(
              child: TextFormField(
                controller: _updateController,
                decoration:
                    InputDecoration(hintText: "please makes changes here"),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    databaseReference.child(id).update({
                      "name": _updateController.text.toString()
                    }).then((value) {
                      Utils().toastMessage("Updated ");
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                    });
                  },
                  child: Text("Update")),
            ],
          );
        });
  }
}
