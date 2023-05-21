import 'package:flutter/material.dart';

class SobPlace extends StatefulWidget {
  const SobPlace({super.key});

  @override
  State<SobPlace> createState() => _SobPlaceState();
}

class _SobPlaceState extends State<SobPlace> {
  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        mainAxisExtent: 260,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            child: Image.asset('images/collage.jpg', fit: BoxFit.fill),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            child: Image.asset(
              'images/Adventure.jpg',
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            child: Image.asset('images/City.jpg', fit: BoxFit.fill),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            child: Image.asset('images/UnderGround.jpg', fit: BoxFit.fill),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            child: Image.asset('images/Travel.jpg', fit: BoxFit.fill),
          ),
        ),
      ],
    );
  }
}
