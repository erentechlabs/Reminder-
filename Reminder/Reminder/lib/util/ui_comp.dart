
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import 'custom_widgets/AddReminderDialog.dart';

class UIComp
{
  Color getColorFromIndex(int index)
  {
    switch (index)
    {
      case 0:
        return const Color(0xFFEB9DA2);
      case 1:
        return const Color(0xFFF0B884);
      case 2:
        return const Color(0xFFBBE8B5);
      case 3:
        return const Color(0xFFACBBE8);
      case 4:
        return const Color(0xFFC5ACE8);
      default:
        return const Color(0xFFEB9DA2);
    }
  }
  int getColorId(Color color) {
    if (color == const Color(0xFFEB9DA2)) {
      return 0;
    } else if (color == const Color(0xFFF0B884)) {
      return 1;
    } else if (color == const Color(0xFFBBE8B5)) {
      return 2;
    } else if (color == const Color(0xFFACBBE8)) {
      return 3;
    } else if (color == const Color(0xFFC5ACE8)) {
      return 4;
    } else {
      return 0; // Default to blue if color not recognized
    }
  }


  void showAddReminderDialog(BuildContext context)
  {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddReminderDialog();
      },
    );
  }
}

class EmptyUI
{
  final String title;

  const EmptyUI({required this.title});


  Widget emptyuibuilder(BuildContext context)
  {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.hourglass_empty,
            size: 64
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }
}

class Confetti
{

  ConfettiController controller = ConfettiController();
  Confetti({required this.controller});

  Widget confettiBuilder(BuildContext context)
  {
    return Align(
        alignment: Alignment.center,
        child: ConfettiWidget(
        confettiController: controller,
        blastDirectionality: BlastDirectionality.explosive,
        maxBlastForce: 100, // set a lower max blast force
        minBlastForce: 10, // set a lower min blast force
        emissionFrequency: 0.02,
        numberOfParticles: 20, // a lot of particles at once
        gravity: 1,
    ),
    );
  }
}

class AlertDialogUI extends StatelessWidget
{
  final VoidCallback onYesPress;
  final VoidCallback onNoPress;
  final String yesButtonText;
  final String noButtonText;
  final String title;

  const AlertDialogUI({
    super.key,
    required this.onYesPress,
    required this.onNoPress,
    required this.yesButtonText,
    required this.noButtonText,
    required this.title,
  });

  @override
  Widget build(BuildContext context)
  {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Colors.red,
            ),
            onPressed: onYesPress,
            child: Text(
              yesButtonText,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Colors.blue,
            ),
            onPressed: onNoPress,
            child: Text(
              noButtonText,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}