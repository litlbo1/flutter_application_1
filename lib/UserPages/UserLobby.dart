import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../Widgets/sob_list/add_sob.dart';
import '../Widgets/sob_list/sob_list.dart';

class UserLobby extends StatefulWidget {
  const UserLobby({super.key});

  @override
  State<UserLobby> createState() => _UserLobbyState();
}

class _UserLobbyState extends State<UserLobby> {
  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF444054),
        title: const Text('Событие'),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                icon: const Icon(
                  Icons.person,
                  size: 35,
                  color: Colors.white,
                ),
              )),
        ],
      ),
      body: Center(child: _page.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Событие',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Друзья',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Избранные',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF444054),
        onTap: _onItemTapped,
      ),
    ));
  }

  static final List<Widget> _page = <Widget>[
    sob_list(),
    Icon(Icons.account_circle_rounded),
    Icon(Icons.access_alarm)
  ];
}
