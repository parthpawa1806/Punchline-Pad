import 'package:hive/hive.dart';
import 'package:punchline_pad/models/datamodel.dart';

class Boxes {
  
  static Box<BitsModels> getData() => Hive.box<BitsModels>('notes');
  static Box<SetsModel> getData2() => Hive.box<SetsModel>('Setsbox');
  static Box<LogsModel> getData3() => Hive.box<LogsModel>('Logsbox');

}
