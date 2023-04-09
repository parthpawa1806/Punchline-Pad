import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:punchline_pad/models/datamodel.dart';
import 'package:punchline_pad/screens/logs/logs.dart';
import 'dart:math';
import '../../boxes/boxes.dart';
import '../../widgets/listBuilder2.dart';
import '../../widgets/switch.dart';
import '../main_screen.dart';
import 'package:intl/intl.dart';

class LogPage extends StatefulWidget {
  @override
  _LogPageState createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  late Box<SetsModel> setsBox;
  String _selectedType = 'Practice';
  String _selectedVenue = '';
  String _selectedPerformance = '';

  List<String> _types = ['Practice', 'Show'];
  List<String> _performances = ['Killed', 'Good', 'Medium', 'Bombed'];
  List<Color> _buttonColors = [
    Colors.green,
    Colors.lightGreen,
    Colors.amber,
    Colors.red,
  ];

  TextEditingController _dateController =TextEditingController(
  text: DateFormat('yyyy-MM-dd').format(DateTime.now()),
);
  TextEditingController _timeController = TextEditingController();
  TextEditingController _venueController = TextEditingController();
  TextEditingController _notesController = TextEditingController();

  Color _generateRandomPastelColor() {
    Random random = new Random();
    int r = 155 + random.nextInt(100);
    int g = 155 + random.nextInt(100);
    int b = 155 + random.nextInt(100);
    return Color.fromARGB(255, r, g, b);
  }

  Widget _buildCard() {
    return Card(
      color: _generateRandomPastelColor(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: 300,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _performances.asMap().entries.map((entry) {
                int index = entry.key;
                String performance = entry.value;

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedPerformance = performance;
                      });
                      _onButtonPressed(index);
                    },
                    child: MyCustomWidget(
                      onText: performance,
                      offText: performance,
                      onColor: _buttonColors[index],
                      offColor: Colors.grey[800],
                      isSelected: _selectedPerformance == performance,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  void _onButtonPressed(int index) {
    int indexx = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                      int? indexx;
                      if (_selectedPerformance == 'Killed') {
                        indexx = 0;
                      }
                      if (_selectedPerformance == 'Good') {
                        indexx = 1;
                      }
                      if (_selectedPerformance == 'Medium') {
                        indexx = 2;
                      }
                      if (_selectedPerformance == 'Bombed') {
                        indexx = 3;
                      }
                      
                      if(_dateController.text.isNotEmpty){
                        final logsModel = LogsModel(
                        date: _dateController.text,
                        type: _selectedType,
                        venue: _venueController.text,
                        notes: _notesController.text,
                        performence: indexx,
                        time:int.tryParse(_timeController.text) ?? 0,
                       );
                       final box = Boxes.getData3();
                       box.add(logsModel);
                     
                      _dateController.clear();
                      _notesController.clear();
                      _notesController.clear();
                      }
                        
                       
                      Navigator.of(context).pushReplacement(
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: Mainscreen(),
                        ),
                      );
                    }),
                SizedBox(width: 5),
                Text(
                  'Logs Editor',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.only(top: 0, left: 2, right: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    _dateController.text,
                    style: GoogleFonts.poppins(
                        color: Colors.black87,
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  ),
                ),
                DropdownButton<String>(
                  value: _selectedType,
                  onChanged: (value) {
                    setState(() {
                      _selectedType = value!;
                    });
                  },
                  items: _types.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(
                        type,
                        style: GoogleFonts.poppins(
                            color: Colors.black87,
                            fontWeight: FontWeight.w300,
                            fontSize: 20),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            if (_selectedType == 'Show')
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontWeight: FontWeight.w300,
                          fontSize: 20),
                      controller: _venueController,
                      decoration: InputDecoration(
                        hintText: 'Venue',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            const Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: GoogleFonts.poppins(
                        color: Colors.black87,
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                    controller: _timeController,
                    decoration: InputDecoration(
                      hintText: 'Time',
                      hintStyle: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w300),
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
            TextField(
              controller: _notesController,
              decoration: InputDecoration(
                hintStyle:
                    GoogleFonts.poppins(color: Colors.black87, fontSize: 20,fontWeight: FontWeight.w300),
                hintText: 'Things to Improve',
                border: InputBorder.none,
              ),
              maxLines: 3,
            ),
            const Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
            Expanded(
              child: setsAdder(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildCard(),
    );
  }
}
