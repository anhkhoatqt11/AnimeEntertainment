import 'dart:ffi';

class DailyQuests {
  final String? id;
  final String? questType;
  final String? questName;
  final int? prize;
  final int? requiredTime;

  DailyQuests({
    this.id,
    this.questType,
    this.questName,
    this.prize,
    this.requiredTime,
  });
}
