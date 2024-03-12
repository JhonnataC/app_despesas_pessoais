import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool swicthValue = true;
  TimeOfDay selectedtime = const TimeOfDay(hour: 19, minute: 00);

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: selectedtime,
      initialEntryMode: TimePickerEntryMode.dial,
    ).then((value) {
      if (value == null) return;
      setState(() {
        selectedtime = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notificações',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Exibir notificações?'),
              Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: swicthValue,
                  onChanged: (value) {
                    setState(() {
                      swicthValue = value;
                    });
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              swicthValue
                  ? Text(
                      ' ${selectedtime.hour}:${selectedtime.minute.toString().padLeft(2, '0')}')
                  : const Text(''),
              TextButton(
                onPressed: swicthValue ? _showTimePicker : null,
                child: const Text(
                  'Selecionar horário',
                  style: TextStyle(fontFamily: 'Gabarito'),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Concluído',
                  style: TextStyle(fontFamily: 'Gabarito'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
