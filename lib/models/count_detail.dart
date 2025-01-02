import 'package:hive/hive.dart';
import 'package:contini_statisticini/models/custom_attribute.dart';

part 'count_detail.g.dart';

@HiveType(typeId: 1)
class CountDetail extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  final int counterId;

  @HiveField(2)
  final int countNumber;

  @HiveField(3)
  DateTime date = DateTime.now();

  @HiveField(4)
  List<Map<String,dynamic>>? attributes;

  CountDetail(
      {required this.id, required this.counterId, required this.countNumber});

  @override
  String toString() {
    return "CountDetail of Counter ${counterId}, with date ${date}";
  }
}
