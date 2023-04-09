import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:punchline_pad/screens/sets/sets.dart';
import 'dart:math';
import '../../boxes/boxes.dart';
import '../../models/datamodel.dart';
import '../../widgets/ListBuilder.dart';
import '../main_screen.dart';

class SetEditPage extends StatefulWidget {
  final SetsModel note;

  const SetEditPage({Key? key, required this.note}) : super(key: key);
  @override
  State<SetEditPage> createState() => _SetEditPageState();
}

class _SetEditPageState extends State<SetEditPage> {  
  late TextEditingController _titleController;
  late TextEditingController _remarkController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _remarkController = TextEditingController(text: widget.note.body);
  }

  @override
  void dispose() {
    _titleController.dispose();
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
      var data = box.values.toList().cast<SetsModel>();
      var killTimes = widget.note.kill_times;
      var bombTimes = widget.note.bomb_times;

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
                      final setModel = SetsModel(
                      title: _titleController.text,
                      body: _remarkController.text,
                      title_list: selectedBitsModels,
                      );
                      final box = Boxes.getData2();
                       int index = box.values.toList().indexOf(widget.note);
                      box.putAt(index,setModel);
                      _titleController.clear();
                       _remarkController.clear();
                    Navigator.of(context).pushReplacement(
                    PageTransition(
                    type: PageTransitionType.leftToRightWithFade,
                    child: Mainscreen(selectedIndex: 1),
                  ),
                );
              }
                  ),
                 SizedBox(width: 5),
                  Text(
                    'Set Editor',
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
              padding: const EdgeInsets.all(23.0),
              child: TextField(
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 20),
                controller: _titleController,
                decoration: const InputDecoration(
                    hintText: 'Set Title', border: InputBorder.none),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 23,right: 23,left: 23),
              child: TextField(
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 20),
                controller: _remarkController,
                decoration: const InputDecoration(
                    hintText: 'Remarks', border: InputBorder.none),
              ),
            ),
          
            Expanded(
              child:BitsAdder() ,
            ),
          ],
        ),
      ),
        bottomNavigationBar: _buildCard()
      
    );
  }
}

