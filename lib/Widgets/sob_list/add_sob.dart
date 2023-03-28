import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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

  final user = FirebaseAuth.instance.currentUser;

  void CreateAcoount() async {
    DocumentReference<Map<String, dynamic>> ref =
        FirebaseFirestore.instance.collection('posts').doc();

    await ref.set({"name": _namesob.text, "discription": _descsob.text});

    _namesob.clear();
    _descsob.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        width: 200,
        child: Column(
          children: [
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
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: ElevatedButton(
                onPressed: () async {
                  CreateAcoount();
                },
                child: Text("Создать"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
