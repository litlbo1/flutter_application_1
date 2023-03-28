import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: userSnapshot.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 185,
                    height: 340,
                    color: Colors.blue,
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: Text(userSnapshot[index]["name"]),
                    ),
                  ),
                ),
              );
            },
            //itemCount: userSnapshot.length,
            //crossAxisCount: userSnapshot.length,
          );
        });
  }
}
