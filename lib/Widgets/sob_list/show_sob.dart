import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    return null;
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
                padding: const EdgeInsets.only(top: 50),
                child: Image(
                  image: NetworkImage(data['image']),
                  width: 420,
                  height: 400,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                height: 80,
                alignment: Alignment.topCenter,
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    "${data['name']}",
                    style:
                        const TextStyle(fontFamily: 'Project1', fontSize: 20),
                  ),
                ),
              ),
              Container(
                height: 50,
                color: Colors.yellow,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        decoration: BoxDecoration(border: Border.all()),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Бесплатно"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        decoration: BoxDecoration(border: Border.all()),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Город"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        decoration: BoxDecoration(border: Border.all()),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Велосипед"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30, left: 30),
                    child: SlideAction(
                      child: const Text("Я пойду"),
                      onSubmit: () async {
                        FavSob(context: context);
                      },
                    ),
                  ),
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
