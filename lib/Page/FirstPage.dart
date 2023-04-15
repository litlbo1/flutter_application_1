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
      backgroundColor: Color(0xFFcddafd),
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
                      child: const Text('Войти'),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor: Color(0xFF444054)),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: SizedBox(
                      width: 370,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegPage()));
                        },
                        child: Text('Создать аккаунт'),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            backgroundColor: Color(0xFF444054)),
                      )))
            ],
          )),
    );
  }
}
