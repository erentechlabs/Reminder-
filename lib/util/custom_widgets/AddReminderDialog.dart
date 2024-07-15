import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:reminder/main.dart';
import 'package:reminder/util/ui_comp.dart';

import '../../database/reminder_db.dart';
import '../../model/reminder.dart';

class AddReminderDialog extends StatefulWidget {
  const AddReminderDialog({super.key});

  @override
  _AddReminderDialogState createState() => _AddReminderDialogState();
}

class _AddReminderDialogState extends State<AddReminderDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _goalController = TextEditingController();
  String _selectedFrequency = 'Daily';
  String _selectedOption = 'Normal';
  Color _selectedColor = const Color(0xFFEB9DA2);
  final double _buttonSize = 36.0;


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: TextField(
        controller: _titleController,
        textCapitalization: TextCapitalization.words,
        maxLines: 1,
        maxLength: 25,
        decoration: const InputDecoration(labelText: 'Title', counterText: ""),
        onChanged: (value) => setState(() {}),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildColorButton(const Color(0xFFEB9DA2),
                  isSelected: _selectedColor == const Color(0xFFEB9DA2)),
              _buildColorButton(const Color(0xFFF0B884),
                  isSelected: _selectedColor == const Color(0xFFF0B884)),
              _buildColorButton(const Color(0xFFBBE8B5),
                  isSelected: _selectedColor == const Color(0xFFBBE8B5)),
              _buildColorButton(const Color(0xFFACBBE8),
                  isSelected: _selectedColor == const Color(0xFFACBBE8)),
              _buildColorButton(const Color(0xFFC5ACE8),
                  isSelected: _selectedColor == const Color(0xFFC5ACE8)),
            ],
          ),

          const SizedBox(height: 20),

          TextField(
            controller: _goalController,
            keyboardType: TextInputType.number,
            maxLines: 1,
            maxLength: 18,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: const InputDecoration(
                labelText: 'Goal', counterText: ''),
            onChanged: (value) => setState(() {}),
          ),

          const SizedBox(height: 20),

          DropdownButtonFormField<String>(
            value: _selectedFrequency,
            decoration: const InputDecoration(
                labelText: 'Frequency', counterText: ''),
            items: ['Daily', 'Weekly', 'Monthly', 'Yearly']
                .map<DropdownMenuItem<String>>(
                  (String value) =>
                  DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ),
            ).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedFrequency = newValue;
                });
              }
            },
          ),

          const SizedBox(height: 20),
          Column(
            children: [
              if(_selectedFrequency == 'Daily')
                _buildOptionCard("Until Tomorrow", 'Normal'),
              if(_selectedFrequency == 'Weekly')
                _buildOptionCard("Until Sunday", 'Normal'),
              if(_selectedFrequency == 'Monthly')
                _buildOptionCard("Until 1st of the Month", 'Normal'),
              if(_selectedFrequency == 'Yearly')
                _buildOptionCard("Until 1st of January", 'Normal'),
              if(_selectedFrequency == 'Daily')
                _buildOptionCard("After 1 Day", 'Extended'),
              if(_selectedFrequency == 'Weekly')
                _buildOptionCard("After 7 Days", 'Extended'),
              if(_selectedFrequency == 'Monthly')
                _buildOptionCard("After 30 Days", 'Extended'),
              if(_selectedFrequency == 'Yearly')
                _buildOptionCard("After 365 Days", 'Extended'),
            ],
          )


        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _titleController.text.isEmpty || _goalController.text.isEmpty ? null : () {
            Reminder remind = Reminder(
              firstDate: DateTime.now(),
              lastChange: DateTime.now(),
              title: _titleController.text,
              frequency: _selectedFrequency,
              count: 0,
              goal: int.parse(_goalController.text),
              colorsId: UIComp().getColorId(_selectedColor),
              selectedOption: _selectedOption,
            );

            rembox.add(remind);

            debugPrint(_selectedOption);
            // Save functionality
            // You can access the entered values using _titleController.text, _goalController.text, _selectedColor, and _selectedFrequency
            Get.back();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }


  Widget _buildColorButton(Color color, {required bool isSelected}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedColor = color;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: isSelected ? _buttonSize + 10 : _buttonSize,
        height: isSelected ? _buttonSize + 10 : _buttonSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(
            color: isSelected ? Colors.black : Colors.transparent,
            width: 2,
          ),
        ),
        child: isSelected ? const Center(
          child: Icon(
            Icons.check,
            //color: Colors.white,
            size: 24,
          ),
        ) : null,
      ),
    );
  }

  Widget _buildOptionCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,

        ),
        leading: Radio<String>(
          value: value,
          groupValue: _selectedOption,
          onChanged: (String? newValue) {
            setState(() {
              _selectedOption = newValue!;
            });
          },
        ),
        onTap: () {
          setState(() {
            _selectedOption = value;
          });
        },
      ),
    );
  }
}

