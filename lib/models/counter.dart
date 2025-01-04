import 'package:hive/hive.dart';

part 'counter.g.dart';

@HiveType(typeId: 0)
class Counter {
  @HiveField(0)
  String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  bool requiredAdditionalData = false;

  @HiveField(3)
  final List<Map> properties;

  Counter(
      {required this.id,
      required this.name,
      detailCount = 0,
      required this.properties}) {
    for (Map property in properties) {
      if (property['required']) {
        requiredAdditionalData = true;
      }
    }
  }
}
