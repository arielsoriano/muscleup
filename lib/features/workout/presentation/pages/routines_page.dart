import 'package:flutter/material.dart';

import '../../../../core/utils/l10n_extension.dart';

class RoutinesPage extends StatelessWidget {
  const RoutinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.routines),
      ),
      body: Center(
        child: Text(context.l10n.routines),
      ),
    );
  }
}
