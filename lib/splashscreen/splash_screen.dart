import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/animations/left_to_right_faded_transition.dart';
import 'package:page_animation_transition/animations/scale_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:page_transition/page_transition.dart';
import 'package:punchline_pad/screens/main_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SecondClass extends StatefulWidget {
  @override
  _SecondClassState createState() => _SecondClassState();
}

class _SecondClassState extends State<SecondClass>
    with TickerProviderStateMixin {
  AnimationController? scaleController;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();

    scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            Navigator.of(context).pushReplacement(
              PageAnimationTransition(
                pageAnimationType: ScaleAnimationTransition(),
                page: Mainscreen(),
              ),
            );
            Timer(
              Duration(milliseconds: 300),
              () {
                scaleController!.reset();
              },
            );
          }
        },
      );

    scaleAnimation =
        Tween<double>(begin: 0.0, end: 12).animate(scaleController!);

    Timer(Duration(seconds: 2), () {
      setState(() {
        scaleController!.forward();
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scaleController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: DefaultTextStyle(
          style: TextStyle(fontSize: 30.0),
          child: AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                'Punchline Pad ',
                textStyle: GoogleFonts.poppins(),
                speed: Duration(milliseconds: 160),
              ),
            ],
            isRepeatingAnimation: false,
            repeatForever: false,
            displayFullTextOnTap: false,
          ),
        ),
      ),
    );
  }
}

