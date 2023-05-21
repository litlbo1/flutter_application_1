import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widgets/sob_list/add_sob.dart';
import 'package:flutter_application_1/Widgets/sob_list/sob_list.dart';

class AdminLobby extends StatefulWidget {
  const AdminLobby({super.key});

  @override
  State<AdminLobby> createState() => _AdminLobbyState();
}

class _AdminLobbyState extends State<AdminLobby> {
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
        backgroundColor: const Color(0xFF444054),
        title: const Text('Вы вошли как Админ'),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 10),
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
            label: 'Добавить',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Избранные',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF444054),
        onTap: _onItemTapped,
      ),
    ));
  }

  static final List<Widget> _page = <Widget>[
    const sob_list(),
    const AddSob(),
    const Icon(Icons.access_alarm)
  ];
}
