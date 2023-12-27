import 'package:flutter/material.dart';

class GreenContainer extends StatelessWidget {
  final List<Widget> children;
  const GreenContainer({
    super.key,
    required this.children
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 130,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromARGB(179, 24, 227, 41),
                Color.fromARGB(255, 23, 227, 30)
              ]),
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Color(0xffFFFFFF),
              offset: Offset(-6, -6),
              blurRadius: 8,
            ),
            BoxShadow(
              color: Color.fromARGB(128, 94, 223, 102),
              offset: Offset(8, 8),
              blurRadius: 20,
            )
          ]),
      child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children),
    );
  }
}

class RedContainer extends StatelessWidget {
  final List<Widget> children;
  const RedContainer({super.key,
  required this.children});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 40,
      width: 130,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromARGB(179, 223, 44, 31),
                Color.fromARGB(255, 228, 51, 28)
              ]),
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Color(0xffFFFFFF),
              offset: Offset(-6, -6),
              blurRadius: 8,
            ),
            BoxShadow(
              color: Color.fromARGB(128, 240, 103, 69),
              offset: Offset(8, 8),
              blurRadius: 20,
            )
          ]),
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: children),
    );
  }
}