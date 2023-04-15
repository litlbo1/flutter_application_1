import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Page/EmailVerifyPage.dart';
import 'package:flutter_application_1/Page/ForgotPassPage.dart';
import 'package:flutter_application_1/Page/LoginPage.dart';
import 'package:flutter_application_1/Page/RegisterPage.dart';
import 'package:flutter_application_1/UserPages/UserLobby.dart';
import 'AdminPages/AdminLobby.dart';
import 'Page/CheckUser.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: "sobitiye", options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      //color: Color(0xFFBEBBBB),
      routes: {
        '/first': (context) => const LogPage(),
        '/reg': (context) => const RegPage(),
        '/emailverify': (context) => const EmailVerificationScreen(),
        '/forgot': (context) => const ForgotPass(),
        '/UserLobby': (context) => const UserLobby(),
        '/AdminLobby': (context) => const AdminLobby(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CheckUser(),
    );
  }
}
