import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'datamodel.g.dart';

var date = new DateTime.now().toString();

var dateParse = DateTime.parse(date);

var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

@HiveType(typeId: 1)
class BitsModels extends HiveObject {
  @HiveField(0)
  String? title;

  @HiveField(1)
  String? body;

  @HiveField(2)
  String? time;

  @HiveField(3)
  String? notes;

  @HiveField(4, defaultValue: 0)
  int? kill_times;

  @HiveField(5,defaultValue: 0)
  int? bomb_times;

  BitsModels(
      {required this.title,
      required this.body,
      this.time,
      this.notes,
      this.kill_times});
}

@HiveType(typeId: 2)
class SetsModel extends HiveObject{
  @HiveField(0)
  String? title;

  @HiveField(1)
  String? body;

  @HiveField(2)
  List<BitsModels>? title_list;

  @HiveField(3)
  String? notes;

  @HiveField(4)
  List<String>? bitsofset;

  @HiveField(5, defaultValue: 0)
  int? kill_times;

  @HiveField(6,defaultValue: 0)
  int? bomb_times;

  SetsModel(
      {required this.title, required this.body, this.title_list, this.notes,this.bitsofset,this.kill_times,this.bomb_times});
}

@HiveType(typeId: 3)
class LogsModel extends HiveObject{
  @HiveField(0)
  String? date = formattedDate;

  @HiveField(1)
  String? type;

  @HiveField(2)
  String? venue;

  @HiveField(3)
  List<SetsModel>? sets_list;

  @HiveField(4)
  String? notes;

  @HiveField(5)
  int? performence;

  @HiveField(6)
  int? time;
  
  LogsModel(
      {this.date,
      this.type,
      this.venue,
      this.sets_list,
      this.notes,
      this.performence,this.time});
}
