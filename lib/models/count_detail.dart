import 'package:hive/hive.dart';
import 'package:contini_statisticini/models/custom_attribute.dart';

part 'count_detail.g.dart';


@HiveType(typeId: 1)
class CountDetail {
  @HiveField(0)
  int id;

  @HiveField(1)
  final int counterId;

  @HiveField(2)
  final int countNumber;

  @HiveField(3)
  DateTime date = DateTime.now();

  @HiveField(4)
  CustomAttribute attributes = CustomAttribute(id: 0);

  CountDetail({required this.id, required this.counterId, required this.countNumber});
}