import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/Page/Profile.dart';
import '../Widgets/sob_list/add_sob.dart';
import '../Widgets/sob_list/sob_list.dart';
import 'Favorites.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        backgroundColor: Color(0xFFB8B6D7),
        title: DropdownButton(
            items: dropdownItems,
            value: selectedValue,
            onChanged: (String? newValue) {
              setState(() {
                selectedValue = newValue!;
              });
            }),
        actions: <Widget>[
          //FloatingActionButton(onPressed: () {}),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              width: 70,
              child: Image.network(
                'https://cdn.freelance.ru/images/att/1575043_900_600.png',
                fit: BoxFit.contain,
              ),
            ),
            // IconButton(
            //   onPressed: () async {
            //     await FirebaseAuth.instance.signOut();
            //   },
            //   icon: const Icon(
            //     Icons.person,
            //     size: 35,
            //     color: Colors.black,
            //   ),
            // )
          ),
        ],
      ),
      body: Center(child: _page.elementAt(_selectedIndex)),
      bottomNavigationBar: Container(
        color: Color(0xFFB8B6D7),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GNav(
            tabBackgroundColor: Color(0xFFC5C9E8),
            gap: 4,
            padding: EdgeInsets.all(15),
            tabs: const [
              GButton(
                icon: Icons.list,
                text: "Событие",
                iconSize: 30,
              ),
              GButton(
                icon: Icons.star,
                text: "Избранные",
                iconSize: 30,
              ),
              GButton(
                icon: Icons.map,
                text: "Места",
                iconSize: 30,
              ),
              GButton(
                icon: Icons.supervised_user_circle,
                text: "Профиль",
                iconSize: 30,
              )
            ],
            selectedIndex: _selectedIndex,
            onTabChange: _onItemTapped,
          ),
        ),
      ),
    ));
  }

  static final List<Widget> _page = <Widget>[
    sob_list(),
    FavoriteSob(),
    Icon(Icons.access_alarm),
    UsersProfile()
  ];

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          child: const Text(
            "Москва",
            style: TextStyle(color: Colors.black),
          ),
          value: "Москва"),
      const DropdownMenuItem(
          child: Text("Санкт-Петербург", style: TextStyle(color: Colors.black)),
          value: "Санкт-Петербург"),
      const DropdownMenuItem(
          child: Text("Астрахань", style: TextStyle(color: Colors.black)),
          value: "Астрахань"),
      const DropdownMenuItem(
          child: Text("Самара", style: TextStyle(color: Colors.black)),
          value: "Самара"),
    ];
    return menuItems;
  }

  String selectedValue = "Москва";
}
