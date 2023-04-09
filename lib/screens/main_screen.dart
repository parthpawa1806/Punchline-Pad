import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:punchline_pad/screens/bits/bits.dart';
import 'package:punchline_pad/screens/bits/bits_detail.dart';
import 'package:punchline_pad/screens/logs/logs.dart';
import 'package:punchline_pad/screens/logs/logs_detail.dart';
import 'package:punchline_pad/screens/sets/sets.dart';
import 'package:punchline_pad/screens/sets/sets_detail.dart';


import 'infobot/infobot.dart';

class Mainscreen extends StatefulWidget {
 final int? selectedIndex;
  const Mainscreen({Key? key, this.selectedIndex=0}) : super(key: key);


  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen>
    with SingleTickerProviderStateMixin {
  late TabController? tabController;



  onItemClicked(int index) {
    setState(() {
     tabController!.index = index;
    });
  }

  @override
   void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController?.index = widget.selectedIndex!;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
            automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Punchline Pad', style: TextStyle(
              color: Colors.white,
                )
              ),
          ],
        )
      ),
      floatingActionButton:tabController!.index  == 3 // add this condition to check if in InfoBot screen
          ? null
          : FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: (() {
          if (tabController!.index ==0) {
            Navigator.of(context).pushReplacement(
              PageTransition(
                type: PageTransitionType.leftToRight,
                child: NoteWritingPage(),
              ),
            );
          }
          if (tabController!.index ==1) {
            Navigator.of(context).pushReplacement(
              PageTransition(
                type: PageTransitionType.leftToRight,
                child: SetsDetail(),
              ),
            );
          }
           if (tabController!.index ==2) {
            Navigator.of(context).pushReplacement(
              PageTransition(
                type: PageTransitionType.leftToRight,
                child: LogPage(),
              ),
            );
          }
        }),
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.black,
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: const [
          BitsList(),
          SetsList(),
          LogsList(),
          InfoBot(),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
          child:GNav(
  backgroundColor: Colors.white,
  color: Colors.black,
  tabBackgroundColor: Colors.black,
  gap: 8,
  selectedIndex: tabController!.index,
  onTabChange: onItemClicked,
  padding: EdgeInsets.all(16),
  tabs: const [
    GButton(icon: FeatherIcons.penTool,text: 'Bits',iconColor: Colors.black,textColor: Colors.white,iconActiveColor: Colors.white,),
    GButton(icon: FeatherIcons.clipboard,text: 'Sets',iconColor: Colors.black,textColor: Colors.white,iconActiveColor: Colors.white),  
    GButton(icon: FeatherIcons.book,text: 'Logs',iconColor: Colors.black,textColor: Colors.white,iconActiveColor: Colors.white),  
    GButton(icon: FeatherIcons.info,text: 'Research',iconColor: Colors.black,textColor: Colors.white,iconActiveColor: Colors.white),  
  ],
),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    FeatherIcons.penTool,
    Icons.edit,
    Icons.book,
    Icons.check_box,
  ];
}
