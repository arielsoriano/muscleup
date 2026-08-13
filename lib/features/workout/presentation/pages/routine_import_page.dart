import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/l10n/supported_languages.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/l10n_extension.dart';
import '../../../../core/utils/ui_helpers.dart';
import '../../data/import/routine_import_parser.dart';
import '../../data/import/routine_import_prompt.dart';
import '../../domain/entities/workout_entities.dart';
import '../cubit/routine_import_cubit.dart';
import '../cubit/routine_import_state.dart';

/// Creates routines from a workout plan the user pastes in.
///
/// The app cannot read someone's notes — every set of training notes is
/// formatted differently — but an assistant can, so this screen hands the user
/// the exact instructions to give one and accepts the JSON that comes back.
class RoutineImportPage extends StatelessWidget {
  const RoutineImportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<RoutineImportCubit>(),
      child: const _RoutineImportView(),
    );
  }
}

class _RoutineImportView extends StatefulWidget {
  const _RoutineImportView();

  @override
  State<_RoutineImportView> createState() => _RoutineImportViewState();
}

class _RoutineImportViewState extends State<_RoutineImportView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String get _languageCode => Localizations.localeOf(context).languageCode;

  Future<void> _copyInstructions() async {
    await Clipboard.setData(
      ClipboardData(
        text: RoutineImportPrompt.build(
          languageCode: _languageCode,
          languageName: SupportedLanguages.nativeName(_languageCode),
        ),
      ),
    );

    if (!mounted) return;
    context.showAppSnackBar(
      message: context.l10n.importInstructionsCopied,
      duration: const Duration(seconds: 4),
    );
  }

  Future<void> _pasteFromClipboard() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final text = data?.text ?? '';

    if (!mounted) return;

    if (text.trim().isEmpty) {
      context.showAppSnackBar(
        message: context.l10n.importClipboardEmpty,
        type: SnackBarType.error,
      );
      return;
    }

    _controller.text = text;
    context.read<RoutineImportCubit>().updatePastedText(text);
  }

  void _clear() {
    _controller.clear();
    context.read<RoutineImportCubit>().clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoutineImportCubit, RoutineImportState>(
      listenWhen: (previous, current) =>
          previous.didImport != current.didImport ||
          previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        if (state.didImport) {
          context.showAppSnackBar(message: context.l10n.importSuccess);
          context.pop();
          return;
        }

        final error = state.errorMessage;
        if (error != null) {
          context.showAppSnackBar(message: error, type: SnackBarType.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(context.l10n.importTitle)),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppTheme.spacingMedium,
              AppTheme.spacingMedium,
              AppTheme.spacingMedium,
              AppTheme.spacingXLarge,
            ),
            children: [
              const _IntroCard(),
              const SizedBox(height: AppTheme.spacingLarge),
              const _Steps(),
              const SizedBox(height: AppTheme.spacingMedium),
              FilledButton.icon(
                onPressed: _copyInstructions,
                icon: const Icon(Icons.copy_all_rounded),
                label: Text(context.l10n.importCopyInstructions),
              ),
              const SizedBox(height: AppTheme.spacingSmall),
              Text(
                context.l10n.importInstructionsLanguageNote(
                  SupportedLanguages.nativeName(_languageCode),
                ),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const Divider(height: AppTheme.spacingXLarge),
              _PasteField(
                controller: _controller,
                enabled: !state.isBusy,
                onChanged:
                    context.read<RoutineImportCubit>().updatePastedText,
                onPasteFromClipboard: _pasteFromClipboard,
              ),
              const SizedBox(height: AppTheme.spacingMedium),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: state.isBusy || state.pastedText.isEmpty
                          ? null
                          : _clear,
                      child: Text(context.l10n.importClear),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingMedium),
                  Expanded(
                    child: FilledButton.tonal(
                      onPressed: state.isBusy
                          ? null
                          : context.read<RoutineImportCubit>().check,
                      child: state.isChecking
                          ? const _ButtonSpinner()
                          : Text(context.l10n.importCheck),
                    ),
                  ),
                ],
              ),
              if (state.failure != null) ...[
                const SizedBox(height: AppTheme.spacingMedium),
                _MessageBox(
                  icon: Icons.error_outline_rounded,
                  message: _failureMessage(context, state.failure!),
                  background: Theme.of(context).colorScheme.errorContainer,
                  foreground: Theme.of(context).colorScheme.onErrorContainer,
                ),
              ],
              if (state.preview != null) ...[
                const SizedBox(height: AppTheme.spacingLarge),
                _Preview(
                  result: state.preview!,
                  languageCode: _languageCode,
                ),
                const SizedBox(height: AppTheme.spacingLarge),
                FilledButton.icon(
                  onPressed: state.isBusy
                      ? null
                      : context.read<RoutineImportCubit>().importPreviewed,
                  icon: state.isImporting
                      ? const _ButtonSpinner()
                      : const Icon(Icons.download_done_rounded),
                  label: Text(context.l10n.importAction),
                ),
              ],
            ],
          ),
        );
      },
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.auto_awesome_rounded,
                color: colorScheme.onPrimaryContainer,
              ),
              const SizedBox(width: AppTheme.spacingSmall),
              Expanded(
                child: Text(
                  context.l10n.importHeadline,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingSmall),
          Text(
            context.l10n.importIntro,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                ),
          ),
        ],
      ),
    );
  }
}

class _Steps extends StatelessWidget {
  const _Steps();

  @override
  Widget build(BuildContext context) {
    final steps = <String>[
      context.l10n.importStep1,
      context.l10n.importStep2,
      context.l10n.importStep3,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var index = 0; index < steps.length; index++)
          Padding(
            padding: const EdgeInsets.only(bottom: AppTheme.spacingMedium),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _StepBadge(number: index + 1),
                const SizedBox(width: AppTheme.spacingMedium),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                      steps[index],
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _StepBadge extends StatelessWidget {
  const _StepBadge({required this.number});

  final int number;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 26,
      height: 26,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        shape: BoxShape.circle,
      ),
      child: Text(
        '$number',
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: colorScheme.onSecondaryContainer,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _PasteField extends StatelessWidget {
  const _PasteField({
    required this.controller,
    required this.enabled,
    required this.onChanged,
    required this.onPasteFromClipboard,
  });

  final TextEditingController controller;
  final bool enabled;
  final ValueChanged<String> onChanged;
  final VoidCallback onPasteFromClipboard;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                context.l10n.importPasteLabel,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            TextButton.icon(
              onPressed: enabled ? onPasteFromClipboard : null,
              icon: const Icon(Icons.content_paste_rounded, size: 18),
              label: Text(context.l10n.importPasteFromClipboard),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacingSmall),
        TextField(
          controller: controller,
          enabled: enabled,
          onChanged: onChanged,
          minLines: 6,
          maxLines: 12,
          keyboardType: TextInputType.multiline,
          textCapitalization: TextCapitalization.none,
          autocorrect: false,
          enableSuggestions: false,
          style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          decoration: InputDecoration(
            hintText: context.l10n.importPasteHint,
            alignLabelWithHint: true,
          ),
        ),
      ],
    );
  }
}

class _Preview extends StatelessWidget {
  const _Preview({required this.result, required this.languageCode});

  final RoutineImportResult result;
  final String languageCode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.importPreviewTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppTheme.spacingSmall),
        for (final routine in result.routines)
          _RoutinePreviewCard(routine: routine, languageCode: languageCode),
        if (result.notices.isNotEmpty) ...[
          const SizedBox(height: AppTheme.spacingMedium),
          _MessageBox(
            icon: Icons.info_outline_rounded,
            title: context.l10n.importNoticesTitle,
            message: result.notices
                .map((notice) => '• ${_noticeMessage(context, notice)}')
                .join('\n'),
            background:
                Theme.of(context).colorScheme.surfaceContainerHighest,
            foreground: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ],
      ],
    );
  }
}

class _RoutinePreviewCard extends StatelessWidget {
  const _RoutinePreviewCard({
    required this.routine,
    required this.languageCode,
  });

  final WorkoutRoutine routine;
  final String languageCode;

  @override
  Widget build(BuildContext context) {
    final setCount = routine.exercises
        .fold<int>(0, (total, exercise) => total + exercise.templateSets.length);

    return Card(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingSmall),
      child: Theme(
        // The expansion tile's own divider fights the card outline.
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingMedium,
          ),
          title: Text(
            routine.name,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          subtitle: Text(
            context.l10n.importRoutineSummary(
              routine.exercises.length,
              setCount,
            ),
          ),
          children: [
            for (final exercise in routine.exercises)
              ListTile(
                dense: true,
                contentPadding: const EdgeInsets.only(
                  left: AppTheme.spacingLarge,
                  right: AppTheme.spacingMedium,
                ),
                title: Text(exercise.displayName(languageCode)),
                subtitle: Text(
                  [
                    _formatSets(exercise),
                    if (exercise.notes != null) exercise.notes!,
                  ].join(' · '),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Condenses the template sets into one line — "4 × 10 reps · 22.5 kg" when
  /// they are identical, and a set-by-set list when they are not, which is what
  /// makes a mistranscribed pyramid visible before it is imported.
  String _formatSets(WorkoutExercise exercise) {
    final sets = exercise.templateSets;
    if (sets.isEmpty) return '';

    final descriptions = sets.map(_formatSet).toSet();
    if (descriptions.length == 1) {
      final single = descriptions.first;
      return single.isEmpty ? '${sets.length}' : '${sets.length} × $single';
    }

    return sets.map(_formatSet).join(' / ');
  }

  String _formatSet(WorkoutSet set) {
    final parts = <String>[
      if (set.targetValue2 != null)
        '${set.targetValue2!.formatClean()}${_unitLabel(set.unit2)}',
      if (set.targetValue1 != null)
        '${set.targetValue1!.formatClean()}${_unitLabel(set.unit1)}',
    ];
    return parts.join(' · ');
  }

  String _unitLabel(WorkoutUnit? unit) {
    return switch (unit) {
      WorkoutUnit.kilograms => ' kg',
      WorkoutUnit.pounds => ' lb',
      WorkoutUnit.repetitions => '',
      WorkoutUnit.seconds => ' s',
      WorkoutUnit.minutes => ' min',
      WorkoutUnit.kilometers => ' km',
      WorkoutUnit.meters => ' m',
      WorkoutUnit.level => ' lvl',
      WorkoutUnit.incline => '%',
      WorkoutUnit.none => '',
      null => '',
    };
  }
}

class _MessageBox extends StatelessWidget {
  const _MessageBox({
    required this.icon,
    required this.message,
    required this.background,
    required this.foreground,
    this.title,
  });

  final IconData icon;
  final String message;
  final String? title;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: foreground, size: AppTheme.iconSizeSmall),
          const SizedBox(width: AppTheme.spacingSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: foreground,
                        ),
                  ),
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: foreground,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ButtonSpinner extends StatelessWidget {
  const _ButtonSpinner();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 18,
      height: 18,
      child: CircularProgressIndicator(strokeWidth: 2),
    );
  }
}

String _failureMessage(BuildContext context, RoutineImportFailure failure) {
  return switch (failure) {
    RoutineImportFailure.emptyInput => context.l10n.importErrorEmptyInput,
    RoutineImportFailure.invalidJson => context.l10n.importErrorInvalidJson,
    RoutineImportFailure.noRoutines => context.l10n.importErrorNoRoutines,
  };
}

String _noticeMessage(BuildContext context, RoutineImportNotice notice) {
  return switch (notice.kind) {
    RoutineImportNoticeKind.routineWithoutExercises =>
      context.l10n.importNoticeNoExercises(notice.subject),
    RoutineImportNoticeKind.skippedRoutines =>
      context.l10n.importNoticeSkippedRoutines(notice.count),
    RoutineImportNoticeKind.skippedExercises =>
      context.l10n.importNoticeSkippedExercises(notice.subject, notice.count),
    RoutineImportNoticeKind.duplicateRoutineName =>
      context.l10n.importNoticeDuplicateName(notice.subject),
  };
}
