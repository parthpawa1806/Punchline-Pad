import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:punchline_pad/models/datamodel.dart';
import 'package:punchline_pad/screens/bits/bit_edit.dart';
import 'dart:math';
import '../../boxes/boxes.dart';
import 'bits_detail.dart';
import 'dart:ui';

class BitsList extends StatefulWidget {
  const BitsList({super.key});

  @override
  State<BitsList> createState() => _BitsListState();
}

class _BitsListState extends State<BitsList> {
  @override
  Widget build(BuildContext context) {
    Color _generateRandomPastelColor() {
      Random random = new Random();
      int r = 255 - random.nextInt(100);
      int g = 255 - random.nextInt(100);
      int b = 255 - random.nextInt(100);
      return Color.fromARGB(255, r, g, b);
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: ValueListenableBuilder<Box<BitsModels>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<BitsModels>();

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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                NoteEditingPage(note: data[index]),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[index].title.toString(),
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                data[index].body.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                ),
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      FeatherIcons.thumbsUp,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      data[index].kill_times =
                                          (data[index].kill_times ?? 0) + 1;
                                    },
                                  ),
                                  SizedBox(width: 20),
                                  IconButton(
                                    icon: Icon(
                                      FeatherIcons.thumbsDown,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      data[index].bomb_times =
                                          (data[index].bomb_times ?? 0) + 1;
                                    },
                                  ),
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
                  );
                }),
          );
        },
      ),
    );
  }
}
