import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'counter.g.dart';

@HiveType(typeId: 0)
class Counter {
  @HiveField(0)
  int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  int detailCount = 0;

  @HiveField(3)
  bool requiredAdditionalData = false;

  @HiveField(4)
  final List<Map> properties;

  Counter(
      {required this.id,
      required this.name,
      detailCount = 0,
      required this.properties}) {
    this.detailCount = detailCount;
    for (Map property in properties) {
      if (property['required']) {
        requiredAdditionalData = true;
      }
    }
  }
}
