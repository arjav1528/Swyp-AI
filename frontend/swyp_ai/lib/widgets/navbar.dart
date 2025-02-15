
import 'package:flutter/material.dart';
import 'package:swyp_ai/screens/profile.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});
  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFF060c14),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon:Icon(Icons.bookmark_outline,color: Colors.white, size: 24,),
                  onPressed: () {
                  },),
                IconButton(
                  icon:Icon(Icons.add,color: Colors.white, size: 24,),
                  onPressed: () {
                  },),
                IconButton(
                    icon:Icon(Icons.person_outline,color: Colors.white, size: 24,),
                     onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                     },),
              ],
            ),
          ),
        ),
      );
  }
}
