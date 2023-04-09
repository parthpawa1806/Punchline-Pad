import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:punchline_pad/models/datamodel.dart';
import 'package:punchline_pad/widgets/editor.dart';
import 'dart:math';
import '../boxes/boxes.dart';

List<SetsModel> selectedsetssModels = [];

class setsAdder extends StatefulWidget {
  @override
  _BitsAdderState createState() => _BitsAdderState();
}

class _BitsAdderState extends State<setsAdder> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  late Box<SetsModel> bitsBox;
  late Box<LogsModel> logsBox;

  Color _generateRandomPastelColor() {
    Random random = new Random();
    int r = 255 - random.nextInt(100);
    int g = 255 - random.nextInt(100);
    int b = 255 - random.nextInt(100);
    return Color.fromARGB(255, r, g, b);
  }

  @override
  void initState() {
    super.initState();
    bitsBox = Boxes.getData2();
    logsBox = Boxes.getData3();
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  bool _isAlreadySelected(SetsModel bitsModel) {
    return selectedsetssModels.contains(bitsModel);
  }

  void _addToSelected(SetsModel bitsModel) {
    if (!_isAlreadySelected(bitsModel)) {
      setState(() {
        selectedsetssModels.add(bitsModel);
      });
    }
  }

  void _removeFromSelected(SetsModel bitsModel) {
    setState(() {
      selectedsetssModels.remove(bitsModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: 
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Text(
                  'Sets Performed',
                  style: GoogleFonts.poppins(color: Colors.black87,fontWeight: FontWeight.w500),
            ),
               ],

             ),
          
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: bitsBox.listenable(),
                builder: (context, Box<SetsModel> box, _) {
                  final bitsList = box.values.toList().cast<SetsModel>();
                  return ListView.builder(
                    itemCount: bitsList.length,
                    itemBuilder: (context, index) {
                      final bitsModel = bitsList[index];
                      return ListTile(
                        title: Text(bitsModel.title ?? ''),
                        subtitle: Text(bitsModel.body ?? ''),
                        onTap: () {
                          _addToSelected(bitsModel);
                        },
                      );
                    },
                  );
                },
              ),
            ),
            VerticalDivider(
              thickness: 1.0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: selectedsetssModels.length,
                itemBuilder: (context, index) {
                  final bitsModel = selectedsetssModels[index];
                  return ListTile(
                    title: Text(bitsModel.title ?? ''),
                    trailing: IconButton(
                      onPressed: () {
                        _removeFromSelected(bitsModel);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
void addToSetsModelBox(
    String title, String body, List<SetsModel> setsModelsList) {
  final logsModel =
      LogsModel(sets_list: setsModelsList);
  final logsBox = Boxes.getData3();
  logsBox.add(logsModel);
}

