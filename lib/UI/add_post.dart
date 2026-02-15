import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/Utilits/errorToast.dart'; // Import your toast utility
import 'package:flutter_firebase/Widgets/button.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  final postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Post"),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent.shade700,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              maxLines: 4,
              controller: postController,
              decoration: InputDecoration(
                hintText: "Enter Post",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.purpleAccent.shade700),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Button(
              title: "Submit Post",
              // Pass the loading state to your button if it supports it
              onPressed: () {
                setState(() {
                  loading = true;
                });

                // Create a unique ID for each post using timestamp
                String id = DateTime.now().millisecondsSinceEpoch.toString();

                databaseRef.child(id).set({
                  'id': id,
                  'title': postController.text.toString(),
                }).then((value) {
                  setState(() {
                    loading = false;
                  });
                  postController.clear();
                  Errortoast().SuccessToast("Post added successfully");
                }).onError((error, stackTrace) {
                  setState(() {
                    loading = false;
                  });
                  Errortoast().showToast(error.toString());
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}