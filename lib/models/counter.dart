import 'package:hive/hive.dart';

part 'counter.g.dart';

@HiveType(typeId: 0)
class Counter {
  @HiveField(0)
  int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int detailCount;

  Counter({required this.id, required this.name, this.detailCount = 0});
}