import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/Page/sob_model.dart';
import 'package:slide_to_act/slide_to_act.dart';

class ShowSo extends StatelessWidget {
  const ShowSo(
      {super.key, required this.ID, required this.names, required this.Images});

  final String ID;
  final String names;
  final String Images;

  Future<User?> FavSob({required BuildContext context}) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      DocumentReference<Map<String, dynamic>> ref = FirebaseFirestore.instance
          .collection('users-fav')
          .doc(user!.uid)
          .collection("favorites")
          .doc(ID);

      final uid = user.uid;

      await ref.set({"sob": ID, "name_sob": names, "image_sob": Images});
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
    CollectionReference ref = FirebaseFirestore.instance.collection('posts');
    return FutureBuilder<DocumentSnapshot>(
      future: ref.doc(ID).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
              body: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 50),
                child: Image(
                  image: NetworkImage(data['image']),
                  width: 420,
                  height: 400,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 40, right: 250),
                child: Text(
                  "${data['name']}",
                  style: TextStyle(fontFamily: 'Project1', fontSize: 20),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, right: 250),
                child: Text(
                  "Бесплатно",
                  style: TextStyle(fontFamily: 'Project1', fontSize: 15),
                ),
              ),
              Container(
                width: 300,
                padding: EdgeInsets.only(top: 200),
                child: SlideAction(
                  child: const Text("Я пойду"),
                  onSubmit: () async {
                    FavSob(context: context);
                  },
                ),
              )
            ],
          ));
        }
        return Container(
          color: Colors.white,
        );
      },
    );
  }
}
