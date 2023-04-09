import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCustomWidget extends StatelessWidget {
  final bool? isSelected;
  final Function? onTap;
  final Color? onColor;
  final Color? offColor;
  final String? onText;
  final String? offText;

  MyCustomWidget({
    this.isSelected,
    this.onTap,
    this.onColor,
    this.offColor,
    this.onText,
    this.offText,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.fastLinearToSlowEaseIn,
        height: isSelected! ? 40 : 40,
        width: isSelected! ? 75 : 75,
        decoration: BoxDecoration(
          color: isSelected! ? onColor : offColor,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isSelected! ? 0.5 : 0.5),
              blurRadius: isSelected! ? 7 : 8,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Center(
          child: Text(
            isSelected! ? onText! : offText!,
            style: GoogleFonts.poppins(
              color: isSelected! ? Colors.black.withOpacity(0.9) : Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
