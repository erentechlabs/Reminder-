import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomWidget extends StatelessWidget {
  final String title;
  final String lastChange;
  final int counter;
  final int goal;
  final DateTime date;
  final String remainingTime;
  final Color color;
  final VoidCallback onLongPress;
  final VoidCallback onNormalPress;
  final VoidCallback onDecreasePress;
  final VoidCallback onIncreasePress;

  const CustomWidget({
    super.key,
    required this.title,
    required this.lastChange,
    required this.counter,
    required this.goal,
    required this.onLongPress,
    required this.onNormalPress,
    required this.onDecreasePress,
    required this.onIncreasePress,
    required this.date,
    required this.remainingTime,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: color,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.25),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 1),
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 100,
              child: IconButton(
                icon: const Icon(Icons.remove),
                onPressed: (counter == 0) ? null : onDecreasePress,
              ),
            ),
            Expanded(
              child: Container( // Expanded widget'ı saran bir Container ekledik
                padding: const EdgeInsets.symmetric(vertical: 8.0), // Dikey padding ekledik
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          // Buton basıldığında
                          return color.withOpacity(0.8); // Renk biraz koyulaştırılsın
                        } else {
                          // Normal durum
                          return color;
                        }
                      },
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  onLongPress: onLongPress,
                  onPressed: onNormalPress,
                  child: (counter >= goal) ?
                  PageView(
                    scrollDirection: Axis.horizontal,
                    children:
                    [
                      Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: AutoSizeText(
                                title,
                                maxLines: 1,
                                style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold ),
                              ),
                            ),
                          ),
                          const FittedBox(
                            fit: BoxFit.contain,
                            child: AutoSizeText(
                              'Task Completed',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                  ),
                Center(
                  child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       const FittedBox(
                         fit: BoxFit.contain,
                         child: AutoSizeText(
                                               'Goaled and Achieved',
                         style: TextStyle(fontSize: 16.0),
                                               ),
                       ),
                       FittedBox(
                         fit: BoxFit.contain,
                         child: AutoSizeText(
                           goal.toString(),
                           style: const TextStyle(fontSize: 16.0),
                         ),
                       ),
                     ],
                  ),
                ),
                Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  const FittedBox(
                    fit: BoxFit.contain,
                    child: AutoSizeText(
                        'Completion Time',
                        style: TextStyle(fontSize: 16.0),
                      ),
                  ),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: AutoSizeText(
                        lastChange,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],),)]) : PageView(
                    scrollDirection: Axis.horizontal,
                    children:
                    [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: AutoSizeText(
                                  title,
                                  maxLines: 1,
                                  style: const TextStyle(fontSize: 24.0),
                                ),
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.contain,
                              child: AutoSizeText(
                                'Current : $counter Goal : $goal',
                                style: const TextStyle(fontSize: 18.0),
                              ),
                            ),

                          ],
                        ),
                      ),

                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const FittedBox(
                              fit: BoxFit.contain,
                              child: AutoSizeText(
                                'Last Changed',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.contain,
                              child: AutoSizeText(
                                'Day: ${date.day} Month: ${date.month} Year: ${date.year}',
                                style: const TextStyle(fontSize: 14.0),
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.contain,
                              child: AutoSizeText(
                                  'Hour: ${date.hour} Minute: ${date.minute} Second: ${date.second}',
                                  style: const TextStyle(fontSize: 12.0)
                              ),
                            ),
                          ],
                        ),
                      ),

                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const FittedBox(
                              fit: BoxFit.contain,
                              child: AutoSizeText(
                                'Remaining Time',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.contain,
                              child: AutoSizeText(
                                remainingTime,
                                style: const TextStyle(fontSize: 14.0),
                              ),
                            ),

                          ],
                        ),
                      ),
                   ],
                  ) ,
                ),
              ),
            ),
            SizedBox(
              height: 100,
              child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: (counter >= goal) ? null : onIncreasePress,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
