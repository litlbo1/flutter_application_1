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
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    alignment: Alignment.topCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: Text(
                                        userSnapshot[index]['name_sob'],
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 5, left: 5),
                                    child: Container(
                                      alignment: Alignment.bottomLeft,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.green.shade100,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all()),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(2.0),
                                                  child: Center(
                                                    child: Text(
                                                      "Бесплатно",
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all()),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(2.0),
                                                  child: Center(
                                                    child: Text(
                                                      "до 10:00",
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            //flex: 1,
                            child: Column(
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                      alignment: Alignment.topRight,
                                      child: const Icon(Icons.warning)),
                                )),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(),
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
                                                  title: const Text(
                                                      "Удалить Событие"),
                                                  content:
                                                      const SingleChildScrollView(
                                                    child: ListBody(
                                                      children: [
                                                        Text(
                                                            "Вы точно хотите удалить событие?")
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text(
                                                            "Отмена")),
                                                    TextButton(
                                                        onPressed: () {
                                                          DeleteSob();
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text(
                                                            "Удалить"))
                                                  ],
                                                );
                                              });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
