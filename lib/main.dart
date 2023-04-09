import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:punchline_pad/models/datamodel.dart';
import 'package:punchline_pad/screens/bits/bits_detail.dart';
import 'package:punchline_pad/screens/logs/logs_detail.dart';
import 'package:punchline_pad/screens/main_screen.dart';
import 'package:punchline_pad/screens/sets/sets_detail.dart';
import 'package:punchline_pad/splashscreen/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:hive/hive.dart';
import 'package:punchline_pad/widgets/ListBuilder.dart';
import 'package:punchline_pad/widgets/editor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await path.getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(BitsModelsAdapter());
  Hive.registerAdapter(SetsModelAdapter());
  Hive.registerAdapter(LogsModelAdapter());
  await Hive.openBox<BitsModels>('notes');
  await Hive.openBox<SetsModel>('Setsbox');
  await Hive.openBox<LogsModel>('Logsbox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Punchline Pad',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: SecondClass(),
    );
  }
}
