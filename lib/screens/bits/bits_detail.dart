import 'dart:convert';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:punchline_pad/boxes/boxes.dart';
import 'package:punchline_pad/main.dart';
import 'package:punchline_pad/models/datamodel.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:feather_icons/feather_icons.dart';

import '../main_screen.dart';

class NoteWritingPage extends StatefulWidget {
  const NoteWritingPage({Key? key}) : super(key: key);

  @override
  _NoteWritingPageState createState() => _NoteWritingPageState();
}

class _NoteWritingPageState extends State<NoteWritingPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title:Padding(
        padding:const EdgeInsets.only(top: 15, bottom: 5, right: 0, left: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              iconSize: 30,
              icon: const Icon(FeatherIcons.arrowLeft),
              onPressed: () {
                String text = _textController.text;
                int wordCount = 0;

                // count the number of words in the text
                if (text.isNotEmpty) {
                  wordCount = text.trim().split(' ').length;
                }
                // calculate the time in seconds
                String timeInSeconds = (wordCount / 225 * 60).toString();
                if(_titleController.text.isNotEmpty){
                       final data = BitsModels(
                    title: _titleController.text,
                    body: _textController.text,
                    notes: _remarkController.text,
                    time: timeInSeconds);
                    final box = Boxes.getData();
                    box.add(data);
                //data.save();
                  _textController.clear();
                  _titleController.clear();
                  _remarkController.clear();
                }
                
                
               
                Navigator.of(context).pushReplacement(
                  PageTransition(
                    
                    type: PageTransitionType.rightToLeft,
                    child: Mainscreen(),
                  ),
                );
              },
            ),
            SizedBox(width: 5),
                  Text(
                    'Bit Editor',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),

                  ),
          ],
        ),
      )
      ),
      backgroundColor: Colors.white,
      body: Padding(
       padding: const EdgeInsets.only(top: 0, left: 2, right: 2),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                style: GoogleFonts.poppins(color: Colors.black87, fontSize: 22,fontWeight: FontWeight.w600),
                controller: _titleController,
                decoration: const InputDecoration(
                    hintText: 'Bit Title', border: InputBorder.none,hintStyle: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                style: GoogleFonts.poppins(fontWeight: FontWeight.w300),
                controller: _remarkController,
                decoration: const InputDecoration(
                    hintText: 'Remarks', border: InputBorder.none,
                    hintStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.black87),),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  maxLines: null,
                  style: GoogleFonts.poppins(color: Colors.black87, fontSize: 20,fontWeight: FontWeight.w300),
                  controller: _textController,
                  expands: true,
                  decoration: const InputDecoration(
                    hintText: 'Write your Bit here',
                    hintStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.black87),
                    border: InputBorder.none,
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
