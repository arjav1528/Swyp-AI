import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  String quote;
  CardWidget({super.key, required this.quote});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    double heightMultiplier = MediaQuery.of(context).size.height / 765;
    double widthMultiplier = MediaQuery.of(context).size.width / 360;
    return Container(
      height: 330 * heightMultiplier,
      width: 330 * widthMultiplier,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Color(0xFF575efb)),
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [Colors.transparent, Color(0xFF0a0c11)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Center(
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  widget.quote,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Montesserat',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20*widthMultiplier, vertical: 20*heightMultiplier),
                child: SizedBox(
                  width: widthMultiplier * 330,
                  child: Row(
                    children: [
                      Icon(
                        Icons.share,
                        size: widthMultiplier * 20,
                        color: Colors.white,
                      ),
                      SizedBox(width: 20*widthMultiplier),
                      Icon(
                        Icons.download_outlined,
                        size: widthMultiplier * 23,
                        color: Colors.white,
                      ),
                      Spacer(),
                      Icon(
                        Icons.save,
                        size: widthMultiplier * 23,
                        color: Colors.white,
                      ),
                      SizedBox(width: 40*widthMultiplier),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
