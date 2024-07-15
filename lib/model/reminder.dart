import 'package:hive/hive.dart';
import 'package:reminder/database/reminder_db.dart';

part 'reminder.g.dart';


@HiveType(typeId: 0)
class Reminder {

  @HiveField(0)
  DateTime? lastChange;

  @HiveField(1)
  DateTime? firstDate;

  @HiveField(2)
  DateTime? nextDate;

  @HiveField(3)
  String title;

  @HiveField(4)
  String frequency;

  @HiveField(5)
  int count;

  @HiveField(6)
  int goal;

  @HiveField(7)
  int colorsId;

  @HiveField(8)
  String selectedOption;

  Reminder({
    required this.firstDate,
    required this.lastChange,
    required this.title,
    required this.frequency,
    required this.count,
    required this.goal,
    required this.colorsId,
    required this.selectedOption,
  }) {
    calculateNextDate();
  }

  // Calculate the next date based on the frequency
  void calculateNextDate() {
    if (firstDate != null) {
      DateTime now = DateTime.now();
      if(selectedOption == "Extended" || selectedOption.isEmpty) {
        switch (frequency) {
          case "Daily":
            nextDate = firstDate!.add(const Duration(days: 1));
            break;
          case "Weekly":
            nextDate = firstDate!.add(const Duration(days: 7));
            break;
          case "Monthly":
            nextDate = DateTime(firstDate!.year, firstDate!.month + 1, firstDate!.day);
            break;
          case "Yearly":
            nextDate = DateTime(firstDate!.year + 1, firstDate!.month, firstDate!.day);
            break;
        }
      }
      else if(selectedOption == "Normal") {
        switch (frequency) {
          case "Daily":
            nextDate = DateTime(now.year, now.month, now.day + 1, 0, 0, 0, 0);
            break;
          case "Weekly":
            nextDate = firstDate!.add(Duration(days: firstDate!.weekday == 7 ? 7 : 7 - firstDate!.weekday));
            break;
          case "Monthly":
            nextDate = DateTime(now.year, now.month + 1, 1, 0, 0, 0, 0);
            break;
          case "Yearly":
            nextDate = DateTime(now.year + 1, 1, 1, 0, 0, 0, 0);
            break;
        }
      }
    }
  }

// Print the difference between the next date and the current date
  String printDateDifference(int index) {
    if (nextDate == null) { return 'Next date is not set.'; }

    final now = DateTime.now();
    final difference = nextDate!.difference(now);

    if (difference.inDays >= 365) {
      final years = difference.inDays ~/ 365;
      final weeks = (difference.inDays % 365) ~/ 7;
      return '$years years, $weeks weeks and ${difference.inDays % 7} days';
    } else if (difference.inDays >= 30) {
      final months = difference.inDays ~/ 30;
      final weeks = (difference.inDays % 30) ~/ 7;
      return weeks == 0 ? '$months months' : '$months months and $weeks weeks';
    } else if (difference.inDays >= 7) {
      final weeks = difference.inDays ~/ 7;
      final days = difference.inDays % 7;
      return days == 0 ? '$weeks weeks' : '$weeks weeks and $days days';
    } else {
      final hours = difference.inHours;
      final minutes = difference.inMinutes % 60;
      if (hours < 24) {
        if (hours == 0 && minutes != 0) {
          return '$minutes minutes';
        }
        else if (hours <= 0 || minutes <= 0) {
          final now = DateTime.now();
          count = 0;
          firstDate = now;
          lastChange = now;
          calculateNextDate();

          Reminder remind = Reminder(
            firstDate: firstDate,
            title: title,
            frequency: frequency,
            lastChange: lastChange,
            count: count,
            goal: goal,
            colorsId: colorsId,
            selectedOption: selectedOption,
          );

          rembox.put(index,remind);



          return 'Reminder reset';
        } else {
          return '$hours hours and $minutes minutes';
        }
      } else {
        final days = difference.inDays;
        final remainingHours = (difference.inHours - days * 24);
        return remainingHours == 0 ? '$days days' : '$days days and $remainingHours hours';
      }
    }
  }
}

