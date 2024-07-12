import 'dart:async';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:reminder/database/reminder_db.dart';
import '../model/reminder.dart';
import '../util/custom_widgets/custom_widgets_of_insert.dart';
import '../util/ui_comp.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  final controller = ConfettiController();
  Timer? _timer;
  bool _isPlaying = false;


  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (rembox.isNotEmpty) { setState(() {}); }
    });
  }



  @override
  void dispose()
  {
    super.dispose();
    _timer?.cancel();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reminder+"), centerTitle: true),
      body: ValueListenableBuilder(
        valueListenable: rembox.listenable(),
        builder: (context, Box box, _) {
          if (box.isEmpty) {
            return const EmptyUI(title: "Empty").emptyuibuilder(context);
          } else {
            return Column(
              children: [
                Confetti(controller: controller).confettiBuilder(context),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 100),
                    itemCount: box.length,
                    itemBuilder: (BuildContext context, int index) {
                      final key = box.keyAt(index) as int;
                      final Reminder? rem = box.get(key);
                      String lastChange = "${rem!.lastChange!.year.toString()}-${rem.lastChange!.month.toString()}-${rem.lastChange!.day.toString()} ${rem.lastChange!.hour.toString()}:${rem.lastChange!.minute.toString()}:${rem.lastChange!.second.toString()}";
                      return CustomWidget(
                        title: rem.title,
                        lastChange: lastChange,
                        counter: rem.count,
                        goal: rem.goal,
                        remainingTime: rem.printDateDifference(key),
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialogUI(
                                title: "Do you want to delete?",
                                yesButtonText: "Yes",
                                noButtonText: "No",
                                onYesPress: () {
                                  box.deleteAt(index);
                                  Get.back();
                                },
                                onNoPress: () {
                                  Get.back();
                                },
                              ).build(context);
                            },
                          );
                        },
                        onNormalPress: () {},
                        onIncreasePress: () {
                          if (rem.count < rem.goal) {
                            setState(() {
                              rem.count++;
                              rem.lastChange = DateTime.now();
                              if (rem.count >= rem.goal) {
                                rem.count = rem.goal;
                                if (!_isPlaying) {
                                  _isPlaying = true;
                                  controller.play();
                                  Timer(const Duration(seconds: 3), () {
                                    controller.stop();
                                    _isPlaying = false;
                                  });
                                }
                              }
                              box.put(key, rem);
                            });
                          }
                        },
                        onDecreasePress: () {
                          if (rem.count > 0) {
                            setState(() {
                              rem.count--;
                              rem.lastChange = DateTime.now();
                              box.put(key, rem);
                            });
                          }
                        },
                        date: rem.lastChange ?? DateTime.now(),
                        color: UIComp().getColorFromIndex(rem.colorsId),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          UIComp().showAddReminderDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

