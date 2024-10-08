import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';  // Import for Firebase Storage

class EditItem extends StatefulWidget {
  final Map _shoppingItem;

  EditItem(this._shoppingItem, {Key? key}) : super(key: key);

  @override
  _EditItemState createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  late DocumentReference _reference;
  late TextEditingController _controllerName;
  late TextEditingController _controllerQuantity;

  final GlobalKey<FormState> _key = GlobalKey();

  File? _imageFile; // For storing the selected image file
  String? _imageUrl; // For storing the uploaded image URL

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    // Initialize controllers with current data
    _controllerName = TextEditingController(text: widget._shoppingItem['name']);
    _controllerQuantity =
        TextEditingController(text: widget._shoppingItem['quantity']);
    _imageUrl = widget._shoppingItem['image'];

    // Get reference to the document
    _reference = FirebaseFirestore.instance
        .collection('image_add')
        .doc(widget._shoppingItem['id']);
  }

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // Function to upload the image to Firebase Storage and get the download URL
  Future<String?> _uploadImage(File image) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('images')
          .child(fileName);

      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit an item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                controller: _controllerName,
                decoration:
                InputDecoration(hintText: 'Enter the name of the item'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the item name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _controllerQuantity,
                decoration: InputDecoration(
                    hintText: 'Enter the quantity of the item'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the item quantity';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Display the selected image
              _imageFile != null
                  ? Image.file(_imageFile!, height: 200)
                  : _imageUrl != null
                  ? Image.network(_imageUrl!, height: 200)
                  : Container(height: 200, child: Icon(Icons.image)),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Select Image from Gallery'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    String name = _controllerName.text;
                    String quantity = _controllerQuantity.text;

                    // If the user has picked a new image, upload it to Firebase Storage
                    if (_imageFile != null) {
                      _imageUrl = await _uploadImage(_imageFile!);
                    }

                    // Create the data map
                    Map<String, String> dataToUpdate = {
                      'name': name,
                      'quantity': quantity,
                      if (_imageUrl != null) 'image': _imageUrl!,
                    };

                    // Update Firestore document
                    await _reference.update(dataToUpdate);

                    // Optionally show a message and go back
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Item updated successfully')),
                    );
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
