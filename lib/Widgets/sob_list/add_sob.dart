import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseDatabase database = FirebaseDatabase.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class AddSob extends StatefulWidget {
  const AddSob({super.key});

  @override
  State<AddSob> createState() => _AddSobState();
}

class _AddSobState extends State<AddSob> {
  final TextEditingController _namesob = TextEditingController();
  final TextEditingController _descsob = TextEditingController();
  final TextEditingController _photourl = TextEditingController();

  String imageUrl = '';

  final user = FirebaseAuth.instance.currentUser;

  CheckFields() {
    String text1, text2;

    text1 = _namesob.text;
    text2 = _descsob.text;

    if (text1.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Добавте Название События')));
    }
    if (text2.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Добавте Название События')));
    } else {
      CreateAcoount();
    }
  }

  void CreateAcoount() async {
    if (imageUrl.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Добавте фото')));
      return;
    }

    CollectionReference ref = FirebaseFirestore.instance.collection('posts');

    String docId = ref.doc().id;

    await ref.doc(docId).set({
      "name": _namesob.text,
      "discription": _descsob.text,
      "image": imageUrl,
      "id": docId
    });

    _namesob.clear();
    _descsob.clear();
  }

  void PhotoPicker() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    print('${file?.path}');

    if (file == null) return;

    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');

    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    referenceImageToUpload.putFile(File(file.path));

    try {
      await referenceImageToUpload.putFile(File(file.path));

      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        width: 200,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Добавить Событие',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: GestureDetector(
                onTap: () {
                  PhotoPicker();
                },
                child: const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blue,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: TextField(
                controller: _namesob,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Название События'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: TextField(
                controller: _descsob,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Описание'),
              ),
            ),
            SizedBox(
              width: 200,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: ElevatedButton(
                  onPressed: () async {
                    CheckFields();
                  },
                  child: const Text("Создать"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
