import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisExtent: 270),
            itemCount: userSnapshot.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                child: Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFFDCD6D6),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    clipBehavior: Clip.hardEdge,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image(
                            image: NetworkImage(userSnapshot[index]["image"]),
                            height: 210,
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              child: Text(userSnapshot[index]["name"]),
                            ),
                          ),
                        ])),
              );
            },
            //itemCount: userSnapshot.length,
            //crossAxisCount: userSnapshot.length,
          );
        });
  }
}
