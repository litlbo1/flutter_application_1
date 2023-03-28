import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/Page/EmailVerifyPage.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseDatabase database = FirebaseDatabase.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class RegPage extends StatefulWidget {
  const RegPage({super.key});

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  static Future<User?> signUp(
      {required String emailController,
      required String passwordController,
      required BuildContext context}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController, password: passwordController);

      final user = FirebaseAuth.instance.currentUser;

      DocumentReference<Map<String, dynamic>> ref =
          FirebaseFirestore.instance.collection('users').doc(user!.uid);

      final uid = user.uid;

      await ref.set({
        "email": emailController,
        "password": passwordController,
        "city": "city",
        "role": "user"
      });

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Создать аккаунт'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: SizedBox(
            width: 300,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: TextField(
                    controller: _emailController,
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
                      fillColor: Colors.white,
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
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      hintText: 'Password',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50),
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
                                await signUp(
                                    emailController:
                                        _emailController.text.trim(),
                                    passwordController:
                                        _passwordController.text.trim(),
                                    context: context);
                                if (auth.currentUser != null) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EmailVerificationScreen()));
                                  ;
                                }
                                setState(() {
                                  _isLoading = false;
                                });
                              },
                              child: Text('Создать аккаунт'),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  backgroundColor: Color(0xFF444054)),
                            )),
                ),
              ],
            )),
      ),
    );
  }
}
