import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class States extends StatefulWidget {
  const States({super.key});

  @override
  State<States> createState() => _StatesState();
}

//Проверка статуса пользователя
class _StatesState extends State<States> {
  checkuser() {
    User? user = FirebaseAuth.instance.currentUser;
    var check = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSanpshot) {
      if (documentSanpshot.exists) {
        if (documentSanpshot.get('role') == "admin") {
          Navigator.pushNamed(context, '/AdminLobby');
        } else {
          Navigator.pushNamed(context, '/UserLobby');
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('ошибка')));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Welcome'),
      ),
      body: checkuser(),
    );
  }
}
