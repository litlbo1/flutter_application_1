import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseDatabase database = FirebaseDatabase.instance;

class LogPage extends StatefulWidget {
  const LogPage({super.key});

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<User?> signIn(
      {required String emailController,
      required String passwordController,
      required BuildContext context}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController, password: passwordController);

      checkuser();

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Wrong Email')));
      } else if (e.code == 'password-wrong') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Wrong Password')));
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  void checkuser() {
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
      backgroundColor: Color(0xFFBEBBBB),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFBEBBBB),
      ),
      body: Container(
        alignment: Alignment.center,
        child: SizedBox(
            width: 350,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.green),
                      ),
                      hintText: 'Email',
                      fillColor: Color(0xFFBEBBBB),
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.green),
                      ),
                      hintText: 'Password',
                      fillColor: Color(0xFFBEBBBB),
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30, left: 150),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/forgot');
                    },
                    child: Text('Забыл пароль?'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: SizedBox(
                      width: 150,
                      height: 50,
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                await signIn(
                                    emailController:
                                        _emailController.text.trim(),
                                    passwordController:
                                        _passwordController.text.trim(),
                                    context: context);
                                if (auth.currentUser != null) {}
                                setState(() {
                                  _isLoading = false;
                                });
                              },
                              child: Text('Войти'),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  backgroundColor: Color(0xFF444054)),
                            )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 200),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/AdminLoginPage');
                    },
                    child: Text('Админ'),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
