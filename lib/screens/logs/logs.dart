import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:page_transition/page_transition.dart';
import 'package:punchline_pad/screens/sets/set_edit.dart';
import 'package:punchline_pad/screens/sets/sets_detail.dart';
import 'dart:math' ;
import '../../boxes/boxes.dart';
import '../../models/datamodel.dart';
import 'logs_edit.dart';

class LogsList extends StatefulWidget {
  const LogsList({super.key});

  @override
  State<LogsList> createState() => _LogsListState();
}

class _LogsListState extends State<LogsList> {

@override
 Color _generateRandomPastelColor() {
    Random random = new Random();
    int r = 255 - random.nextInt(100);
    int g = 255 - random.nextInt(100);
    int b = 255 - random.nextInt(100);
    return Color.fromARGB(255, r, g, b);
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ValueListenableBuilder<Box<LogsModel>>(
        valueListenable: Boxes.getData3().listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<LogsModel>();
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: ListView.builder(
              itemCount: box.length,
              reverse: true,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                onTap: () {
               Navigator.of(context).pushReplacement(
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: LogEditPage(logsModel: data[index]),
                        ),
                      );
  },
  child: Card(
    color: _generateRandomPastelColor(),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Container(
      height: 220,
      padding: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              
              children: [
                Text(
                  'Date: ',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                Text(
                  data[index].date.toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,

                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                 Text(
                  'Time Performed: ',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                Text(
                  data[index].time.toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w700

                  ),
                ),
                Text(
                  ' mins',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ],
            ),
            if(data[index].type.toString()=='Show')
               Row(
              children: [
                 Text(
                  'Venue: ',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                Text(
                  data[index].venue.toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ],
            ),
          Row(
              children: [
                 Text(
                  'Performence: ',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                if(data[index].performence==0)
                   Text(
                  'Killed',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w700

                  ),
                ),
              if(data[index].performence==1)
                   Text(
                  'Good',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w700

                  ),
                ),
              if(data[index].performence==2)
                   Text(
                  'Medium',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w700

                  ),
                ),    
              if(data[index].performence==3)
                   Text(
                  'Bombed',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w700

                  ),
                ), 
              ],
            ),  
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(
                    FeatherIcons.trash,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // Delete the note from the database
                    data[index].delete();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  ),
) ,
                );
              },
            ),
          );
        },
      ),
    );
  }
}