import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  bool isUploading = false; // Track upload state

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = File(image.path);
      setState(() {});
    }
  }

  Future<void> addContentToHomepage(String collectionName) async {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();
    final price = priceController.text.trim();

    if (selectedImage == null || title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text("Please select an image and fill title and description!")),
      );
      return;
    }

    setState(() {
      isUploading = true;
    });
    try {
      String addId = randomAlphaNumeric(10);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("bookImages").child(addId);
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

      var downloadUrl = await (await task).ref.getDownloadURL();

      await FirebaseFirestore.instance.collection(collectionName).add({
        'title': title,
        'description': description,
        'imageURL': downloadUrl,
        if (price.isNotEmpty) 'price': price,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Content added successfully!")),
      );

      titleController.clear();
      descriptionController.clear();
      priceController.clear();
      selectedImage = null;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to add content: $e")),
      );
    } finally {
      setState(() {
        isUploading = false; // Hide progress indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E251A),
      appBar: AppBar(
        title: const Text(
          "Admin Page",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: getImage,
                child: selectedImage == null
                    ? Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                        ),
                      )
                    : Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            selectedImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                style: const TextStyle(color: Colors.white),
                controller: titleController,
                decoration: const InputDecoration(
                    labelText: "Title",
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white))),
              ),
              TextField(
                style: const TextStyle(color: Colors.white),
                controller: descriptionController,
                decoration: const InputDecoration(
                    labelText: "Description",
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white))),
              ),
              TextField(
                style: const TextStyle(color: Colors.white),
                controller: priceController,
                decoration: const InputDecoration(
                    labelText: "Price (optional)",
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white))),
              ),
              const SizedBox(height: 20),
              if (isUploading)
                const CircularProgressIndicator(
                  color: Colors.white,
                )
              else
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => addContentToHomepage('book_content'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      child: const Text("Add to Books",
                          style: TextStyle(color: Colors.black)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      onPressed: () => addContentToHomepage('author_content'),
                      child: const Text("Add to Authors",
                          style: TextStyle(color: Colors.black)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      onPressed: () => addContentToHomepage('event_content'),
                      child: const Text("Add to Events",
                          style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
