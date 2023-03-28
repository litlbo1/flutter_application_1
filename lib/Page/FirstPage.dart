import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'LoginPage.dart';
import 'RegisterPage.dart';

class First extends StatelessWidget {
  const First({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 200),
                child: Text(
                  'Добро Пожаловать В Событие',
                  style: TextStyle(fontSize: 20, color: Colors.green),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LogPage()));
                          },
                          child: const Text('Войти')))),
              Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegPage()));
                          },
                          child: Text('Создать аккаунт'))))
            ],
          )),
    );
  }
}
