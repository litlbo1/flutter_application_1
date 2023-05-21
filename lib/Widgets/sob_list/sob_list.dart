import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widgets/sob_list/show_sob.dart';

class sob_list extends StatefulWidget {
  const sob_list({super.key});

  @override
  State<sob_list> createState() => _sob_listState();
}

class _sob_listState extends State<sob_list> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          final userSnapshot = snapshot.data?.docs;
          if (userSnapshot!.isEmpty) {
            return const Text('no data');
          }
          return Container(
            color: Colors.white,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 370,
              ),
              itemCount: userSnapshot.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 5.0),
                  child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3))
                          ],
                          color: Colors.grey.shade200,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      clipBehavior: Clip.hardEdge,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShowSo(
                                            ID: userSnapshot[index]["id"],
                                            names: userSnapshot[index]['name'],
                                            Images: userSnapshot[index]
                                                ['image'])));
                              },
                              child: Image(
                                image:
                                    NetworkImage(userSnapshot[index]["image"]),
                                height: 270,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black45)),
                                        child: const Text("Бесплатно"),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black45)),
                                      child: Text(userSnapshot[index]["Tag"]),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  userSnapshot[index]["name"],
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ])),
                );
              },
            ),
          );
        });
  }
}
