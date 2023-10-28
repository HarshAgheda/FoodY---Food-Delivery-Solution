import 'package:flutter/material.dart';

class OrderDateTimeDialog extends StatefulWidget {
  final Function(DateTime) onDateTimeSelected;

  const OrderDateTimeDialog({required this.onDateTimeSelected});

  @override
  _OrderDateTimeDialogState createState() => _OrderDateTimeDialogState();
}

class _OrderDateTimeDialogState extends State<OrderDateTimeDialog> {
  late DateTime selectedDateTime;

  @override
  void initState() {
    super.initState();
    // Set initial value to current date and time
    selectedDateTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Order Date and Time'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: Text('Date: ${selectedDateTime.toLocal().toString().split(' ')[0]}'),
            onTap: _showDatePicker,
          ),
          ListTile(
            leading: const Icon(Icons.access_time),
            title: Text('Time: ${selectedDateTime.toLocal().toString().split(' ')[1].substring(0, 5)}'),
            onTap: _showTimePicker,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onDateTimeSelected(selectedDateTime); // Pass the selected date and time back to the parent widget
            Navigator.of(context).pop();
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
  Future<void> _showDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (pickedDate != null && pickedDate != selectedDateTime) {
      setState(() {
        selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          selectedDateTime.hour,
          selectedDateTime.minute,
        );
      });
    }
  }

  Future<void> _showTimePicker() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDateTime),
    );

    if (pickedTime != null) {
      setState(() {
        selectedDateTime = DateTime(
          selectedDateTime.year,
          selectedDateTime.month,
          selectedDateTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }
}


// class _OrderDateTimeDialogState extends State<OrderDateTimeDialog> {
//   late DateTime selectedDateTime;
//   //CHANGED------------------------------
//   _OrderDateTimeDialogState({required DateTime initialDateTime}) {
//     selectedDateTime = initialDateTime;
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     // Set initial value to current date and time
//     selectedDateTime = DateTime.now();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Select Order Date and Time'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ListTile(
//             leading: const Icon(Icons.calendar_today),
//             title: Text('Date: ${selectedDateTime.toLocal().toString().split(' ')[0]}'),
//             onTap: _showDatePicker,
//           ),
//           ListTile(
//             leading: const Icon(Icons.access_time),
//             title: Text('Time: ${selectedDateTime.toLocal().toString().split(' ')[1].substring(0, 5)}'),
//             onTap: _showTimePicker,
//           ),
//         ],
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: const Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             widget.onDateTimeSelected(selectedDateTime);
//             Navigator.of(context).pop();
//           },
//           child: const Text('Confirm'),
//         ),
//       ],
//     );
//   }
//
//   Future<void> _showDatePicker() async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: selectedDateTime,
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(const Duration(days: 30)),
//     );
//
//     if (pickedDate != null && pickedDate != selectedDateTime) {
//       setState(() {
//         selectedDateTime = DateTime(
//           pickedDate.year,
//           pickedDate.month,
//           pickedDate.day,
//           selectedDateTime.hour,
//           selectedDateTime.minute,
//         );
//       });
//     }
//   }
//
//   Future<void> _showTimePicker() async {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.fromDateTime(selectedDateTime),
//     );
//
//     if (pickedTime != null) {
//       setState(() {
//         selectedDateTime = DateTime(
//           selectedDateTime.year,
//           selectedDateTime.month,
//           selectedDateTime.day,
//           pickedTime.hour,
//           pickedTime.minute,
//         );
//       });
//     }
//   }
// }
