import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:punchline_pad/screens/sets/sets.dart';
import 'package:punchline_pad/widgets/ListBuilder.dart';
import '../../boxes/boxes.dart';
import '../../models/datamodel.dart';
import '../main_screen.dart';

class SetsDetail extends StatefulWidget {
  const SetsDetail({super.key});

  @override
  State<SetsDetail> createState() => _SetsDetailState();
}

class _SetsDetailState extends State<SetsDetail> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                    if(_titleController.text.isNotEmpty){
                      final setModel = SetsModel(
                      title: _titleController.text,
                      body: _remarkController.text,
                      title_list: selectedBitsModels,
                      );
                      final box = Boxes.getData2();
                      box.add(setModel);
                      _titleController.clear();
                       _remarkController.clear();
                    }
                    Navigator.of(context).pushReplacement(
                    PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: Mainscreen(),
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
               style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 22),
                controller: _titleController,
                decoration: const InputDecoration(
                    hintText: 'Set Title', border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 22)
                    ),
              ),
            ),
            const Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
            Padding(
              padding: const EdgeInsets.only(top: 23,right: 23,left: 23),
              child: TextField(
                    style: GoogleFonts.poppins(color: Colors.black87,fontWeight: FontWeight.w300,fontSize: 20),
                controller: _remarkController,
                decoration: const InputDecoration(
                    hintText: 'Remarks', border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.black87,fontWeight: FontWeight.w300,fontSize: 20),
                    ),
              ),
            ),
          const Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
            Expanded(
              child:BitsAdder() ,
            ),
          ],
        ),
      ),
    );
  }
}