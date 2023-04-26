import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _secnameController = TextEditingController();
  bool _isLoading = false;

  static Future<User?> signUp(
      {required String emailController,
      required String passwordController,
      required String nameController,
      required String secnameController,
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
        "name": nameController,
        "SecondName": secnameController,
        "email": emailController,
        "password": passwordController,
        "city": "city",
        "role": "user",
        "sob": ""
      });

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Wrong Email')));
      } else if (e.code == 'password-wrong') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Wrong Password')));
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
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/gif.blur.gif"), fit: BoxFit.cover)),
        alignment: Alignment.center,
        child: SizedBox(
            width: 300,
            child: SingleChildScrollView(
                child: Column(
              children: [
                const Padding(
                    padding: EdgeInsets.only(top: 250, right: 170),
                    child: Text("Создать\nАккаунт",
                        style:
                            TextStyle(fontFamily: 'Project1', fontSize: 25))),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      hintText: 'Name',
                      //fillColor: Colors.white,
                      filled: false,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: TextField(
                    controller: _secnameController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      hintText: 'Second Name',
                      //fillColor: Colors.white,
                      filled: false,
                    ),
                  ),
                ),
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
                      //fillColor: Colors.white,
                      filled: false,
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
                      //fillColor: Colors.white,
                      filled: false,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
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
                                    nameController: _nameController.text.trim(),
                                    secnameController:
                                        _secnameController.text.trim(),
                                    emailController:
                                        _emailController.text.trim(),
                                    passwordController:
                                        _passwordController.text.trim(),
                                    context: context);
                                if (auth.currentUser != null) {
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EmailVerificationScreen()));
                                }
                                setState(() {
                                  _isLoading = false;
                                });
                              },
                              // ignore: sort_child_properties_last
                              child: const Text('Создать аккаунт'),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  backgroundColor: const Color(0xFF444054)),
                            )),
                ),
              ],
            ))),
      ),
    );
  }
}
