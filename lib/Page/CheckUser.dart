import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'FirstPage.dart';
import 'LoginPage.dart';
import 'State.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseDatabase database = FirebaseDatabase.instance;

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

final user = FirebaseAuth.instance.currentUser;

class _CheckUserState extends State<CheckUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Future<void> ref = FirebaseFirestore.instance
                  .collection('users')
                  .doc(user!.uid)
                  .get()
                  .then((DocumentSnapshot documentSanpshot) {
                if (documentSanpshot.exists) {
                  if (documentSanpshot.get('role') == "admin") {
                    Navigator.pushReplacementNamed(context, '/AdminLobby');
                  } else {
                    Navigator.pushReplacementNamed(context, '/UserLobby');
                  }
                }
              });
              return const Text("Вы вошли");
            } else {
              return const First();
            }
          }),
    );
  }
}
