import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteSob extends StatelessWidget {
  String? id;

  FavoriteSob({super.key});

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users-fav')
            .doc(user!.uid)
            .collection("favorites")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          final userSnapshot = snapshot.data?.docs;
          if (userSnapshot!.isEmpty) {
            return const Text('У вас нету избранных событий');
          }
          return ListView.builder(
              itemCount: userSnapshot.length,
              itemExtent: 160,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border:
                            Border.all(color: Colors.black.withOpacity(0.2))),
                    clipBehavior: Clip.hardEdge,
                    child: ClipRect(
                      child: Row(
                        children: [
                          Image(
                              image: NetworkImage(
                                  userSnapshot[index]["image_sob"])),
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(userSnapshot[index]['name_sob']),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 150),
                            child: Container(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                icon: const Icon(Icons.exit_to_app),
                                onPressed: () {
                                  id = userSnapshot[index]['sob'];
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Удалить Событие"),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: const [
                                                Text(
                                                    "Вы точно хотите удалить событие?")
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Отмена")),
                                            TextButton(
                                                onPressed: () {
                                                  DeleteSob();
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Удалить"))
                                          ],
                                        );
                                      });
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
  }

  void DeleteSob() async {
    Future<void> ref = FirebaseFirestore.instance
        .collection('users-fav')
        .doc(user!.uid)
        .collection("favorites")
        .doc(id)
        .delete();
  }
}

class SobModel {
  final int id;

  const SobModel({required this.id});
}
