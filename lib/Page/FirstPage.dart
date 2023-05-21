import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'RegisterPage.dart';

class First extends StatelessWidget {
  const First({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFcddafd),
      body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/gif.blur.gif"), fit: BoxFit.cover)),
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(top: 400, left: 30),
                child: const Text(
                  'Твое Событие',
                  style: TextStyle(
                      fontFamily: 'Project1',
                      fontSize: 30,
                      color: Colors.white),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: SizedBox(
                    width: 370,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LogPage()));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor: const Color(0xFF444054)),
                      child: const Text('Войти'),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: SizedBox(
                      width: 370,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegPage()));
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            backgroundColor: const Color(0xFF444054)),
                        child: const Text('Создать аккаунт'),
                      )))
            ],
          )),
    );
  }
}
