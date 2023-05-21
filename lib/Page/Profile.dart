import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class UsersProfile extends StatefulWidget {
  const UsersProfile({super.key});

  @override
  State<UsersProfile> createState() => _UsersProfileState();
}

class _UsersProfileState extends State<UsersProfile> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(user!.uid).get(),
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
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/1575043_900_600.jpg'),
                      radius: 110,
                    )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 70),
                  child: Center(
                    child: Text(
                      data['email'],
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Container(
                  height: 350,
                  decoration: const BoxDecoration(
                      color: Color(0xFFB8B6D7),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45),
                          topRight: Radius.circular(45))),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Удалить Событие"),
                                      content: const SingleChildScrollView(
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
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Отмена")),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Удалить"))
                                      ],
                                    );
                                  });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0, top: 40),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Color(0xFFC5C9E8),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, top: 5, bottom: 5, right: 5),
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.pink.shade100,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(15))),
                                        child: const Icon(Icons.person),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 30),
                                      child: Text(
                                        "Сменить Данные",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(left: 50),
                                        child: Icon(
                                          Icons.arrow_forward,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0, top: 20),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Color(0xFFC5C9E8),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, top: 5, bottom: 5, right: 5),
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.blue.shade100,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(15))),
                                        child: const Icon(Icons.settings),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 30),
                                      child: Text(
                                        "Настройки",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 105),
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.arrow_forward),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.pushReplacementNamed(context, '/first');
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0, top: 20),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Color(0xFFC5C9E8),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, top: 5, bottom: 5, right: 5),
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.yellow.shade100,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(15))),
                                        child: const Icon(Icons.exit_to_app),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 30),
                                      child: Text(
                                        "Выйти",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 140),
                                      child: Icon(Icons.arrow_forward),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return const Text("loading");
      },
    );
  }
}
