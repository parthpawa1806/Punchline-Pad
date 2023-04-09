import 'dart:convert';
import 'dart:math';
import 'package:punchline_pad/widgets/bottomcard.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:punchline_pad/boxes/boxes.dart';
import 'package:punchline_pad/main.dart';
import 'package:punchline_pad/models/datamodel.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../main_screen.dart';

class NoteEditingPage extends StatefulWidget {
  final BitsModels note;

  const NoteEditingPage({Key? key, required this.note}) : super(key: key);

  @override
  _NoteEditingPageState createState() => _NoteEditingPageState();
}

class _NoteEditingPageState extends State<NoteEditingPage> {
  late TextEditingController _titleController;
  late TextEditingController _textController;
  late TextEditingController _remarkController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _textController = TextEditingController(text: widget.note.body);
    _remarkController = TextEditingController(text: widget.note.notes);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
    _remarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color _generateRandomPastelColor() {
      Random random = new Random();
      int r = 255 - random.nextInt(100);
      int g = 255 - random.nextInt(100);
      int b = 255 - random.nextInt(100);
      return Color.fromARGB(255, r, g, b);
    }

    Widget _buildCard() {
      final box = Boxes.getData();
      var data = box.values.toList().cast<BitsModels>();
      var killTimes = widget.note.kill_times;
      var bombTimes = widget.note.bomb_times;
      var time = widget.note.time;

      return Card(
        color: _generateRandomPastelColor(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          width: 300,
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        'Kill times: $killTimes, Bomb times: $bombTimes',
                        style: GoogleFonts.poppins(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.w400)),
                             Text(
                            'Time:$time mins',
                             style: GoogleFonts.poppins(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.w400)),
                  ],
                )),
          ),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
            titleSpacing: 1,
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.white,
            title: Padding(
              padding:
                  const EdgeInsets.only(top: 15, bottom: 5, right: 0, left: 0),
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
                      String timeInSeconds =
                          (wordCount / 225 * 60).toStringAsFixed(2);
                      final data = BitsModels(
                          title: _titleController.text,
                          body: _textController.text,
                          notes: _remarkController.text,
                          time: timeInSeconds);
                      final box = Boxes.getData();
                      int index = box.values.toList().indexOf(widget.note);
                      box.putAt(index, data);
                      //data.save();
                      _textController.clear();
                      _titleController.clear();
                      _remarkController.clear();
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
            )),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 0, left: 2, right: 2),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  style: GoogleFonts.poppins(
                      color: Colors.black87,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                  controller: _titleController,
                  decoration: const InputDecoration(
                      hintText: 'Bit Title',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.black87)),
                ),
              ),
              const Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  style: GoogleFonts.poppins(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.w300),
                  controller: _remarkController,
                  decoration: const InputDecoration(
                    hintText: 'Remarks',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.black87),
                  ),
                ),
              ),
              const Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    maxLines: null,
                    style: GoogleFonts.poppins(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                    controller: _textController,
                    expands: true,
                    decoration: const InputDecoration(
                      hintText: 'Write your Bit here',
                      hintStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          color: Colors.black87),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildCard());
  }
}
