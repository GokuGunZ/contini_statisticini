import 'package:hive/hive.dart';

part 'custom_attribute.g.dart';

@HiveType(typeId: 2)
class CustomAttribute {
    @HiveField(0)
    int id;

    @HiveField(1)
    Map<String, dynamic> attributes = {};

    CustomAttribute({required this.id, attributes});
}