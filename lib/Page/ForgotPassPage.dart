import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'FirstPage.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final TextEditingController _forgotpass = TextEditingController();

  Future<User?> resetPass({required String forgotpass}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: forgotpass);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Сообщение Отправлено')));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const First()));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: SizedBox(
          width: 300,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 300),
                child: TextField(
                  controller: _forgotpass,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    hintText: 'Email',
                    //fillColor: Colors.white,
                    filled: false,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                    onPressed: () async {
                      await resetPass(forgotpass: _forgotpass.text.trim());
                    },
                    child: Text("Восстановить")),
              )
            ],
          )),
    ));
  }
}
