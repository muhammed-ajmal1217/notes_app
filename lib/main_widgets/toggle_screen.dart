
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ToggleScreen extends StatelessWidget {
  const ToggleScreen({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
    required this.toggleScreen,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;
  final VoidCallback toggleScreen;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: toggleScreen,
      child: Text(
        text2,
        style: GoogleFonts.raleway(
          color: Color(0xff02B4BF),
          fontSize: screenHeight * 0.020,
        ),
      ),
    );
  }
}