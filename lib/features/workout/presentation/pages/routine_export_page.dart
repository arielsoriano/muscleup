import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/l10n_extension.dart';
import '../../../../core/utils/ui_helpers.dart';
import '../cubit/routine_export_cubit.dart';
import '../cubit/routine_export_state.dart';

/// The other half of the import screen: hands the user their routines back as
/// the same JSON the import reads.
///
/// It exists because the cloud copy is opt-in and Android's own app backup was
/// turned off — without this, someone who never links a Google account has no
/// way to move their routines to a new phone.
class RoutineExportPage extends StatelessWidget {
  const RoutineExportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<RoutineExportCubit>(),
      child: const _RoutineExportView(),
    );
  }
}

class _RoutineExportView extends StatefulWidget {
  const _RoutineExportView();

  @override
  State<_RoutineExportView> createState() => _RoutineExportViewState();
}

class _RoutineExportViewState extends State<_RoutineExportView> {
  bool _didLoad = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Loaded here rather than in initState because the language decides how
    // catalog exercises are spelled in the output, and the locale is not
    // readable until the widget is in the tree.
    if (_didLoad) return;
    _didLoad = true;
    context
        .read<RoutineExportCubit>()
        .load(Localizations.localeOf(context).languageCode);
  }

  Future<void> _copy(String json) async {
    await Clipboard.setData(ClipboardData(text: json));

    if (!mounted) return;
    context.showAppSnackBar(
      message: context.l10n.exportCopied,
      duration: const Duration(seconds: 4),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoutineExportCubit, RoutineExportState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(context.l10n.exportTitle)),
          body: _body(context, state),
        );
      },
    );
  }

  Widget _body(BuildContext context, RoutineExportState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return _CenteredMessage(
        icon: Icons.error_outline_rounded,
        message: context.l10n.exportError,
      );
    }

    if (state.isEmpty) {
      return _CenteredMessage(
        icon: Icons.inbox_rounded,
        message: context.l10n.exportEmpty,
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppTheme.spacingMedium,
        AppTheme.spacingMedium,
        AppTheme.spacingMedium,
        AppTheme.spacingXLarge,
      ),
      children: [
        const _IntroCard(),
        const SizedBox(height: AppTheme.spacingLarge),
        Text(
          context.l10n.exportSummary(
            state.routineCount,
            state.exerciseCount,
            state.setCount,
          ),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: AppTheme.spacingSmall),
        Text(
          context.l10n.exportHistoryNote,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: AppTheme.spacingMedium),
        FilledButton.icon(
          onPressed: () => _copy(state.json),
          icon: const Icon(Icons.copy_all_rounded),
          label: Text(context.l10n.exportCopy),
        ),
        const SizedBox(height: AppTheme.spacingMedium),
        _JsonBox(json: state.json),
      ],
    );
  }
}

class _IntroCard extends StatelessWidget {
  const _IntroCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.save_alt_rounded,
            color: colorScheme.onPrimaryContainer,
          ),
          const SizedBox(width: AppTheme.spacingSmall),
          Expanded(
            child: Text(
              context.l10n.exportIntro,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The export itself, shown rather than only copied.
///
/// Selectable and monospaced on purpose: a backup the user cannot see is one
/// they have to take on faith, and being able to scroll through it and find
/// their own routine names is what makes it believable.
class _JsonBox extends StatelessWidget {
  const _JsonBox({required this.json});

  final String json;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
      ),
      child: SelectableText(
        json,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontFamily: 'monospace',
              color: colorScheme.onSurfaceVariant,
            ),
      ),
    );
  }
}

class _CenteredMessage extends StatelessWidget {
  const _CenteredMessage({required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingXLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: colorScheme.onSurfaceVariant),
            const SizedBox(height: AppTheme.spacingMedium),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
