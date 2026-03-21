import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/l10n_extension.dart';
import '../../../../core/utils/ui_helpers.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../cubit/workout_cubit.dart';
import '../cubit/workout_state.dart';

class RoutinesPage extends StatelessWidget {
  const RoutinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<WorkoutCubit>(),
      child: const _RoutinesPageContent(),
    );
  }
}

class _RoutinesPageContent extends StatelessWidget {
  const _RoutinesPageContent();

  void _showSkinSelector(BuildContext context) {
    final settingsCubit = context.read<SettingsCubit>();
    final currentSkin = settingsCubit.state.currentSkin;

    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTheme.radiusLarge),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 24.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  context.l10n.selectSkin,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 16),
              ...AppSkin.values.map((skin) {
                final isSelected = skin == currentSkin;
                return ListTile(
                  onTap: () {
                    settingsCubit.changeSkin(skin);
                    Navigator.of(context).pop();
                  },
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: skin.primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .outline
                            .withValues(alpha: 0.2),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: skin.primaryColor.withValues(alpha: 0.4),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                  title: Text(
                    _getSkinLocalizedName(context, skin),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                  ),
                  trailing: isSelected
                      ? Icon(
                          Icons.check_circle_rounded,
                          color: skin.primaryColor,
                          size: 28,
                        )
                      : Icon(
                          Icons.circle_outlined,
                          color: Theme.of(context)
                              .colorScheme
                              .outline
                              .withValues(alpha: 0.3),
                          size: 28,
                        ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  tileColor:
                      isSelected ? skin.primaryColor.withValues(alpha: 0.1) : null,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                );
              }),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  String _getSkinLocalizedName(BuildContext context, AppSkin skin) {
    switch (skin) {
      case AppSkin.volt:
        return context.l10n.skinVolt;
      case AppSkin.cyan:
        return context.l10n.skinCyan;
      case AppSkin.crimson:
        return context.l10n.skinCrimson;
      case AppSkin.royalGold:
        return context.l10n.skinRoyalGold;
      case AppSkin.monochrome:
        return context.l10n.skinMonochrome;
    }
  }

  void _showDeleteDialog(BuildContext context, String routineId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.l10n.delete),
        content: Text(context.l10n.deleteRoutineConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(context.l10n.cancel),
          ),
          FilledButton(
            onPressed: () {
              context.read<WorkoutCubit>().deleteRoutine(routineId);
              Navigator.of(dialogContext).pop();
            },
            child: Text(context.l10n.delete),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.routines),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert_rounded),
            onSelected: (value) {
              final currentLocale = Localizations.localeOf(context);
              if (value == 'language') {
                final newLanguageCode =
                    currentLocale.languageCode == 'en' ? 'es' : 'en';
                context.read<SettingsCubit>().changeLanguage(newLanguageCode);
              } else if (value == 'appSkin') {
                _showSkinSelector(context);
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem<String>(
                value: 'appSkin',
                child: Row(
                  children: [
                    const Icon(Icons.palette_rounded),
                    const SizedBox(width: 12),
                    Text(context.l10n.appSkin),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'language',
                child: Row(
                  children: [
                    const Icon(Icons.language_rounded),
                    const SizedBox(width: 12),
                    Text(context.l10n.language),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder<WorkoutCubit, WorkoutState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            success: (routines) {
              if (routines.isEmpty) {
                return Center(
                  child: Text(
                    context.l10n.noRoutines,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              }

              return ListView.builder(
                itemCount: routines.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final routine = routines[index];
                  final isEmptyRoutine = routine.exercises.isEmpty;
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Row(
                        children: [
                          Expanded(child: Text(routine.name)),
                          if (isEmptyRoutine)
                            Chip(
                              label: Text(
                                context.l10n.emptyRoutine,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              visualDensity: VisualDensity.compact,
                            ),
                        ],
                      ),
                      subtitle: Text(
                        '${routine.exercises.length} ${context.l10n.exercises}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.play_arrow_rounded,
                              color: isEmptyRoutine
                                  ? Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withValues(alpha: 0.38)
                                  : null,
                            ),
                            onPressed: isEmptyRoutine
                                ? () {
                                    context.showAppSnackBar(
                                        context.l10n.addExercisesFirst,);
                                  }
                                : () => context.push(
                                      AppRoutes.activeWorkout,
                                      extra: {'routine': routine},
                                    ),
                            tooltip: context.l10n.startWorkout,
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline_rounded),
                            onPressed: () => _showDeleteDialog(
                              context,
                              routine.id,
                            ),
                          ),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                      onTap: () => context.push(
                        AppRoutes.routineDetailsPath(routine.id),
                      ),
                    ),
                  );
                },
              );
            },
            error: (message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.l10n.errorLoading,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => context.read<WorkoutCubit>(),
                    child: Text(context.l10n.retry),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.manageRoutine),
        icon: const Icon(Icons.add_rounded),
        label: Text(context.l10n.addRoutine),
      ),
    );
  }
}
