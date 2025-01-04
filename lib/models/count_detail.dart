import 'package:hive/hive.dart';

part 'count_detail.g.dart';

@HiveType(typeId: 1)
class CountDetail extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String counterId;

  @HiveField(2)
  DateTime? date = DateTime.now();

  @HiveField(3)
  Map<String, dynamic>? attributes;

  CountDetail(
      {required this.id, required this.counterId, this.attributes, this.date});

  @override
  String toString() {
    return "CountDetail of Counter $counterId, with date $date";
  }
}
