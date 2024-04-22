import 'package:flutter/material.dart';
import 'package:projeto_despesas_pessoais/src/ui/providers/notifications_provider.dart';
import 'package:projeto_despesas_pessoais/src/data/services/notifications_service.dart';
import 'package:provider/provider.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Provider.of<PreferencesProvider>(context).loadNotificationTime();
  }

  @override
  Widget build(BuildContext context) {
    final ntProvider = Provider.of<NotificationsProvider>(context);
    TimeOfDay selectedTime = ntProvider.notificationTime;
    bool swicthValue = ntProvider.notificationIsOn;

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
              const Text('Exibir lembrete?'),
              Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: swicthValue,
                  onChanged: (value) {
                    setState(() {
                      ntProvider.changeNotificationMode();
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
                      ' ${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}')
                  : const Text(''),
              TextButton(
                onPressed: swicthValue
                    ? () {
                        showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                          initialEntryMode: TimePickerEntryMode.dial,
                        ).then((value) {
                          if (value == null) return;
                          ntProvider.saveNotificationTime(value);
                        });
                      }
                    : null,
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
                onPressed: () {
                  if (swicthValue) {
                    Provider.of<NotificationsService>(context, listen: false)
                        .showNotification(time: selectedTime);
                  }
                  Navigator.of(context).pop();
                },
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
