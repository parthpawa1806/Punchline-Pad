import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:punchline_pad/screens/sets/set_edit.dart';
import 'package:punchline_pad/screens/sets/sets_detail.dart';
import 'dart:math' ;
import '../../boxes/boxes.dart';
import '../../models/datamodel.dart';

class SetsList extends StatefulWidget {
  const SetsList({super.key});

  @override
  State<SetsList> createState() => _SetsListState();
}

class _SetsListState extends State<SetsList> {

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
      body: ValueListenableBuilder<Box<SetsModel>>(
        valueListenable: Boxes.getData2().listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<SetsModel>();
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
              SetEditPage(note: data[index]),
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
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            data[index].body.toString(),
            style: TextStyle(
              fontSize: 20,
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