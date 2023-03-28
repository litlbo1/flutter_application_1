import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UserLobby extends StatefulWidget {
  const UserLobby({super.key});

  @override
  State<UserLobby> createState() => _UserLobbyState();
}

class _UserLobbyState extends State<UserLobby> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добро Пожаловать'),
      ),
    );
  }
}
