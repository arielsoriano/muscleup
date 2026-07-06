import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/utils/dev_logger.dart';

class DevLogsPage extends StatefulWidget {
  const DevLogsPage({super.key});

  @override
  State<DevLogsPage> createState() => _DevLogsPageState();
}

class _DevLogsPageState extends State<DevLogsPage> {
  @override
  Widget build(BuildContext context) {
    final logs = DevLogger.instance.logs;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dev Logs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: logs.join('\n')));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logs copied to clipboard')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                DevLogger.instance.clear();
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: logs.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            child: SelectableText(
              logs[index],
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          );
        },
      ),
    );
  }
}
