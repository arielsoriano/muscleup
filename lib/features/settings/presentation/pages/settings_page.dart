import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/l10n/supported_languages.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/ui_helpers.dart';
import '../../../../core/utils/l10n_extension.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../auth/presentation/cubit/auth_state.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';
import '../cubit/sync_status_cubit.dart';
import '../cubit/training_defaults_cubit.dart';
import 'dev_logs_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: serviceLocator<AuthCubit>()),
        BlocProvider.value(value: serviceLocator<SettingsCubit>()),
        BlocProvider.value(value: serviceLocator<SyncStatusCubit>()),
        BlocProvider.value(value: serviceLocator<TrainingDefaultsCubit>()),
      ],
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Long-pressing the title is the release escape hatch into the auth
        // logs: invisible to users, but reachable when a tester reports a
        // sign-in problem that only reproduces on their device.
        title: GestureDetector(
          onLongPress: () => _openDevLogs(context),
          child: Text(context.l10n.settings),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingMedium),
        children: [
          const _AccountSection(),
          const _DividerSection(),
          const _SyncSection(),
          const _DividerSection(),
          const _AppearanceSection(),
          const _DividerSection(),
          const _TrainingDefaultsSection(),
          const _DividerSection(),
          const _ExerciseLibrarySection(),
          const _DividerSection(),
          const _LanguageSection(),
          const _DividerSection(),
          const _FeedbackSection(),
          const _DividerSection(),
          const _LegalSection(),
          const _DividerSection(),
          const _AppInfoSection(),
          // Developer-only entry point. The label is untranslated and the page
          // is raw diagnostics, so it stays out of release builds; use the
          // long-press on the title there instead.
          if (kDebugMode) ...[
            const _DividerSection(),
            ListTile(
              leading: const Icon(Icons.bug_report),
              title: const Text('Dev Logs'),
              onTap: () => _openDevLogs(context),
            ),
          ],
        ],
      ),
    );
  }

  void _openDevLogs(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const DevLogsPage()),
    );
  }
}

class _DividerSection extends StatelessWidget {
  const _DividerSection();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, indent: 16, endIndent: 16);
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppTheme.spacingMedium,
        AppTheme.spacingLarge,
        AppTheme.spacingMedium,
        AppTheme.spacingSmall,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
      ),
    );
  }
}

class _AccountSection extends StatelessWidget {
  const _AccountSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(context.l10n.authAccount),
        BlocConsumer<AuthCubit, AuthState>(
          listener: _handleAuthStateChange,
          builder: (context, state) {
            return switch (state) {
              AuthInitializing() || AuthLoading() => const _AuthLoadingTile(),
              AuthAnonymous() => _AuthAnonymousTile(
                  onLinkWithGoogle: context.read<AuthCubit>().linkWithGoogle,
                ),
              AuthLinkedWithGoogle(user: final user) => _AuthLinkedTile(
                  displayName: user.displayName,
                  email: user.email,
                  onDisconnect: context.read<AuthCubit>().disconnectGoogle,
                ),
              AuthError() => _AuthAnonymousTile(
                  onLinkWithGoogle: context.read<AuthCubit>().linkWithGoogle,
                ),
              AuthUnavailable() => const _AuthUnavailableTile(),
            };
          },
        ),
      ],
    );
  }

  void _handleAuthStateChange(BuildContext context, AuthState state) {
    if (state is AuthLinkedWithGoogle) {
      context.showAppSnackBar(
        message: context.l10n.authLinkSuccess,
      );
      return;
    }

    if (state is AuthError) {
      final message = _translateAuthErrorMessage(context, state.message);
      context.showAppSnackBar(
        message: message,
        type: SnackBarType.error,
      );
    }
  }

  String _translateAuthErrorMessage(BuildContext context, String rawMessage) {
    if (rawMessage == 'auth_google_sign_in_configuration_error') {
      return context.l10n.authGoogleSignInConfigurationError;
    }

    if (rawMessage == 'auth_google_sign_in_timeout') {
      return context.l10n.authGoogleSignInTimeout;
    }

    if (rawMessage.startsWith('Exception: ')) {
      return rawMessage.substring('Exception: '.length);
    }

    return rawMessage;
  }
}

class _AuthLoadingTile extends StatelessWidget {
  const _AuthLoadingTile();

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      title: Text('...'),
    );
  }
}

class _AuthAnonymousTile extends StatelessWidget {
  const _AuthAnonymousTile({required this.onLinkWithGoogle});

  final VoidCallback onLinkWithGoogle;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.person_outline_rounded, color: colorScheme.onSurface),
          title: Text(context.l10n.authAnonymous),
          subtitle: Text(
            context.l10n.authAnonymousSubtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppTheme.spacingMedium,
            0,
            AppTheme.spacingMedium,
            AppTheme.spacingMedium,
          ),
          child: SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onLinkWithGoogle,
              icon: const Icon(Icons.login_rounded),
              label: Text(context.l10n.authContinueWithGoogle),
            ),
          ),
        ),
      ],
    );
  }
}

class _AuthLinkedTile extends StatelessWidget {
  const _AuthLinkedTile({
    required this.onDisconnect,
    this.displayName,
    this.email,
  });

  final String? displayName;
  final String? email;
  final VoidCallback onDisconnect;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final accountLabel = displayName ?? email ?? context.l10n.authLinkedWithGoogle;

    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.verified_user_rounded, color: colorScheme.primary),
          title: Text(context.l10n.authLinkedWithGoogle),
          subtitle: Text(
            accountLabel,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppTheme.spacingMedium,
            0,
            AppTheme.spacingMedium,
            AppTheme.spacingMedium,
          ),
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onDisconnect,
              icon: const Icon(Icons.logout_rounded),
              label: Text(context.l10n.authDisconnectGoogle),
            ),
          ),
        ),
      ],
    );
  }
}

class _AuthUnavailableTile extends StatelessWidget {
  const _AuthUnavailableTile();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.cloud_off_rounded,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      title: Text(context.l10n.authUnavailable),
    );
  }
}

class _SyncSection extends StatelessWidget {
  const _SyncSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        final cloudSyncEnabled = authState is AuthLinkedWithGoogle;
        final locale = Localizations.localeOf(context).languageCode;

        return BlocBuilder<SyncStatusCubit, SyncStatusState>(
          builder: (context, syncStatusState) {
            final lastRunMetrics = syncStatusState.lastRunMetrics;

            final lastSyncLabel = lastRunMetrics == null
                ? null
                : DateFormat.yMMMd(locale)
                    .add_jm()
                    .format(lastRunMetrics.endedAt);

            final title = syncStatusState.isSyncing
                ? context.l10n.syncing
                : cloudSyncEnabled
                    ? context.l10n.synced
                    : context.l10n.syncLocked;

            final subtitle = cloudSyncEnabled
                ? (lastSyncLabel == null
                    ? null
                    : context.l10n.lastSync(lastSyncLabel))
                : context.l10n.linkGoogleForSync;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionHeader(context.l10n.syncCloudSection),
                ListTile(
                  leading: Icon(
                    syncStatusState.isSyncing
                        ? Icons.sync_rounded
                        : (cloudSyncEnabled
                            ? Icons.cloud_done_rounded
                            : Icons.cloud_off_rounded),
                  ),
                  title: Text(title),
                  subtitle: subtitle == null ? null : Text(subtitle),
                ),
                if (syncStatusState.isSyncing)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingMedium),
                    child: LinearProgressIndicator(minHeight: 2),
                  ),
                if (syncStatusState.lastErrorMessage != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppTheme.spacingMedium,
                      0,
                      AppTheme.spacingMedium,
                      AppTheme.spacingSmall,
                    ),
                    child: Text(
                      syncStatusState.lastErrorMessage!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                    ),
                  ),
                if (cloudSyncEnabled)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppTheme.spacingSmall,
                      0,
                      AppTheme.spacingSmall,
                      AppTheme.spacingSmall,
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: syncStatusState.isSyncing
                            ? null
                            : context.read<SyncStatusCubit>().syncNow,
                        icon: const Icon(Icons.refresh_rounded),
                        label: Text(context.l10n.refreshNow),
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}

class _AppearanceSection extends StatelessWidget {
  const _AppearanceSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionHeader(context.l10n.appSkin),
            ListTile(
              leading: const Icon(Icons.palette_rounded),
              title: Text(context.l10n.appSkin),
              subtitle: Text(_skinLabel(context, state.currentSkin)),
              onTap: () => _showSkinSelector(context),
            ),
            SwitchListTile(
              secondary: const Icon(Icons.dark_mode_rounded),
              title: Text(context.l10n.darkMode),
              value: state.isDarkMode,
              onChanged: (_) => context.read<SettingsCubit>().toggleDarkMode(),
            ),
          ],
        );
      },
    );
  }

  String _skinLabel(BuildContext context, AppSkin skin) {
    return switch (skin) {
      AppSkin.volt => context.l10n.skinVolt,
      AppSkin.cyan => context.l10n.skinCyan,
      AppSkin.crimson => context.l10n.skinCrimson,
      AppSkin.royalGold => context.l10n.skinRoyalGold,
      AppSkin.monochrome => context.l10n.skinMonochrome,
    };
  }

  void _showSkinSelector(BuildContext context) {
    final settingsCubit = context.read<SettingsCubit>();
    final currentSkin = settingsCubit.state.currentSkin;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTheme.radiusLarge),
        ),
      ),
      builder: (sheetContext) {
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
                    Navigator.of(sheetContext).pop();
                  },
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: skin.primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(sheetContext)
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
                    _skinLabel(sheetContext, skin),
                    style:
                        Theme.of(sheetContext).textTheme.titleMedium?.copyWith(
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
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
                          color: Theme.of(sheetContext)
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
}

class _LanguageSection extends StatelessWidget {
  const _LanguageSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final currentCode = state.locale.languageCode;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionHeader(context.l10n.language),
            ListTile(
              leading: const Icon(Icons.language_rounded),
              title: Text(context.l10n.language),
              subtitle: Text(_languageLabel(currentCode)),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => _showLanguageSelector(context, currentCode),
            ),
          ],
        );
      },
    );
  }

  String _languageLabel(String code) => SupportedLanguages.nativeName(code);

  void _showLanguageSelector(BuildContext context, String currentCode) {
    final settingsCubit = context.read<SettingsCubit>();
    // Driven by the shipped `.arb` files, so a new language appears here as
    // soon as its translations land.
    final options = SupportedLanguages.languageCodes;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      // The list scrolls and the sheet is capped, so the picker keeps working
      // as languages are added instead of overflowing off the screen.
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTheme.radiusLarge),
        ),
      ),
      builder: (sheetContext) {
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
                  context.l10n.language,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 16),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: options.length,
                  itemBuilder: (listContext, index) {
                    final code = options[index];
                    final label = SupportedLanguages.nativeName(code);
                    final isSelected = code == currentCode;

                    return ListTile(
                      onTap: () {
                        settingsCubit.changeLanguage(code);
                        Navigator.of(sheetContext).pop();
                      },
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: Theme.of(sheetContext)
                            .colorScheme
                            .primary
                            .withValues(alpha: 0.12),
                        child: Text(
                          code.toUpperCase(),
                          style: Theme.of(sheetContext).textTheme.labelLarge,
                        ),
                      ),
                      title: Text(
                        label,
                        style: Theme.of(sheetContext)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                      ),
                      trailing: isSelected
                          ? Icon(
                              Icons.check_circle_rounded,
                              color: Theme.of(sheetContext).colorScheme.primary,
                              size: 28,
                            )
                          : Icon(
                              Icons.circle_outlined,
                              color: Theme.of(sheetContext)
                                  .colorScheme
                                  .outline
                                  .withValues(alpha: 0.3),
                              size: 28,
                            ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      tileColor: isSelected
                          ? Theme.of(sheetContext)
                              .colorScheme
                              .primary
                              .withValues(alpha: 0.08)
                          : null,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}

class _TrainingDefaultsSection extends StatelessWidget {
  const _TrainingDefaultsSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainingDefaultsCubit, TrainingDefaultsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Padding(
            padding: EdgeInsets.all(AppTheme.spacingMedium),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final defaults = state.defaults;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionHeader(context.l10n.trainingDefaultsSection),
            ListTile(
              leading: const Icon(Icons.timer_outlined),
              title: Text(context.l10n.defaultRest),
              subtitle: Text(
                defaults.defaultRestSeconds == null
                    ? '-'
                    : '${defaults.defaultRestSeconds} s',
              ),
              trailing: const Icon(Icons.edit_rounded),
              onTap: () => _editIntValue(
                context,
                title: context.l10n.restSecondsDialogTitle,
                initialValue: defaults.defaultRestSeconds,
                min: 15,
                max: 300,
                onSave: (value) =>
                    context.read<TrainingDefaultsCubit>().setDefaultRestSeconds(value),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.repeat_rounded),
              title: Text(context.l10n.defaultRepetitions),
              subtitle: Text(
                defaults.defaultRepetitions == null
                    ? '-'
                    : '${defaults.defaultRepetitions}',
              ),
              trailing: const Icon(Icons.edit_rounded),
              onTap: () => _editIntValue(
                context,
                title: context.l10n.repetitionsDialogTitle,
                initialValue: defaults.defaultRepetitions,
                min: 1,
                max: 50,
                onSave: (value) =>
                    context.read<TrainingDefaultsCubit>().setDefaultRepetitions(value),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.fitness_center_outlined),
              title: Text(context.l10n.defaultWeight),
              subtitle: Text(
                defaults.defaultWeight == null
                    ? '-'
                  : '${defaults.defaultWeight!.toStringAsFixed(1)} kg',
              ),
              trailing: const Icon(Icons.edit_rounded),
              onTap: () => _editDoubleValue(
                context,
                title: context.l10n.weightKgDialogTitle,
                initialValue: defaults.defaultWeight,
                min: 0,
                max: 500,
                onSave: (value) =>
                    context.read<TrainingDefaultsCubit>().setDefaultWeight(value),
              ),
            ),
            SwitchListTile(
              secondary: const Icon(Icons.timer_rounded),
              title: Text(context.l10n.autoStartRestTimerOnComplete),
              subtitle: Text(
                context.l10n.autoStartRestTimerOnCompleteSubtitle,
              ),
              value: defaults.autoStartRestTimerOnSetCompleted,
              onChanged: (value) => context
                  .read<TrainingDefaultsCubit>()
                  .setAutoStartRestTimerOnSetCompleted(value),
            ),
            if (state.errorMessage != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppTheme.spacingMedium,
                  0,
                  AppTheme.spacingMedium,
                  AppTheme.spacingSmall,
                ),
                child: Text(
                  state.errorMessage!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
              ),
          ],
        );
      },
    );
  }

  Future<void> _editIntValue(
    BuildContext context, {
    required String title,
    required int? initialValue,
    required int min,
    required int max,
    required ValueChanged<int?> onSave,
  }) async {
    final controller = TextEditingController(
      text: initialValue?.toString() ?? '',
    );

    final result = await showDialog<int?>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(context.l10n.cancel),
            ),
            FilledButton(
              onPressed: () {
                final text = controller.text.trim();
                if (text.isEmpty) {
                  Navigator.of(dialogContext).pop(null);
                  return;
                }

                final parsed = int.tryParse(text);
                if (parsed == null) {
                  return;
                }
                Navigator.of(dialogContext).pop(parsed.clamp(min, max));
              },
              child: Text(context.l10n.save),
            ),
          ],
        );
      },
    );

    onSave(result);
  }

  Future<void> _editDoubleValue(
    BuildContext context, {
    required String title,
    required double? initialValue,
    required double min,
    required double max,
    required ValueChanged<double?> onSave,
  }) async {
    final controller = TextEditingController(
      text: initialValue?.toStringAsFixed(1) ?? '',
    );

    final result = await showDialog<double?>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(context.l10n.cancel),
            ),
            FilledButton(
              onPressed: () {
                final text = controller.text.trim();
                if (text.isEmpty) {
                  Navigator.of(dialogContext).pop(null);
                  return;
                }

                final raw = text.replaceAll(',', '.');
                final parsed = double.tryParse(raw);
                if (parsed == null) {
                  return;
                }
                final clamped = parsed.clamp(min, max).toDouble();
                Navigator.of(dialogContext).pop(clamped);
              },
              child: Text(context.l10n.save),
            ),
          ],
        );
      },
    );

    onSave(result);
  }
}

class _ExerciseLibrarySection extends StatelessWidget {
  const _ExerciseLibrarySection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(context.l10n.globalManagementSection),
        ListTile(
          leading: const Icon(Icons.fitness_center_rounded),
          title: Text(context.l10n.manageExercises),
          subtitle: Text(context.l10n.manageExercisesSubtitle),
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () => context.push(AppRoutes.exerciseLibrary),
        ),
        ListTile(
          leading: const Icon(Icons.auto_awesome_rounded),
          title: Text(context.l10n.importTitle),
          subtitle: Text(context.l10n.importSettingsSubtitle),
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () => context.push(AppRoutes.importRoutines),
        ),
      ],
    );
  }
}

class _FeedbackSection extends StatelessWidget {
  const _FeedbackSection();

  static const String _contactEmail = AppConstants.contactEmail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(context.l10n.helpFeedbackSection),
        ListTile(
          leading: const Icon(Icons.feedback_outlined),
          title: Text(context.l10n.sendFeedback),
          subtitle: const Text(_contactEmail),
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () => _sendFeedback(context),
        ),
      ],
    );
  }

  Future<void> _sendFeedback(BuildContext context) async {
    final subject = context.l10n.feedbackEmailSubject;
    final bodyIntro = context.l10n.feedbackEmailBody;
    final copiedMessage = context.l10n.emailCopiedToClipboard;

    String version = '';
    String build = '';
    try {
      final info = await PackageInfo.fromPlatform();
      version = info.version;
      build = info.buildNumber;
    } catch (_) {
      // Version info is best-effort; ignore if unavailable.
    }

    final platform = Platform.isAndroid
        ? 'Android'
        : Platform.isIOS
            ? 'iOS'
            : 'Other';

    final body = '$bodyIntro\n\n\n\n'
        '-------------------\n'
        'Muscleup v$version ($build) · $platform';

    final uri = Uri(
      scheme: 'mailto',
      path: _contactEmail,
      query: _encodeQueryParameters({'subject': subject, 'body': body}),
    );

    var launched = false;
    try {
      launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      launched = false;
    }

    if (launched || !context.mounted) {
      return;
    }

    // Fallback: no email client available — copy the address so the user can
    // still reach out.
    await Clipboard.setData(const ClipboardData(text: _contactEmail));
    if (!context.mounted) {
      return;
    }
    context.showAppSnackBar(
      message: copiedMessage,
      type: SnackBarType.info,
    );
  }

  String _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (entry) =>
              '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value)}',
        )
        .join('&');
  }
}

class _LegalSection extends StatelessWidget {
  const _LegalSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(context.l10n.legalSection),
        ListTile(
          leading: const Icon(Icons.privacy_tip_outlined),
          title: Text(context.l10n.privacyPolicy),
          subtitle: Text(context.l10n.privacyPolicySubtitle),
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () => context.push(AppRoutes.privacyPolicy),
        ),
      ],
    );
  }
}

class _AppInfoSection extends StatefulWidget {
  const _AppInfoSection();

  @override
  State<_AppInfoSection> createState() => _AppInfoSectionState();
}

class _AppInfoSectionState extends State<_AppInfoSection> {
  late final Future<PackageInfo> _packageInfoFuture;

  @override
  void initState() {
    super.initState();
    _packageInfoFuture = PackageInfo.fromPlatform();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(context.l10n.appInfoSection),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppTheme.spacingMedium,
            0,
            AppTheme.spacingMedium,
            AppTheme.spacingSmall,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.25),
              ),
            ),
            child: FutureBuilder<PackageInfo>(
              future: _packageInfoFuture,
              builder: (context, snapshot) {
                final version = snapshot.hasData
                    ? snapshot.data!.version
                    : '...';
                final build = snapshot.hasData
                    ? snapshot.data!.buildNumber
                    : '...';

                return ListTile(
                  leading: Icon(
                    Icons.info_outline_rounded,
                    color: colorScheme.primary,
                  ),
                  title: Text(
                    '${context.l10n.appVersionLabel} $version',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    '${context.l10n.appBuildLabel} $build',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                  trailing: Icon(
                    Icons.verified_rounded,
                    color: colorScheme.primary.withValues(alpha: 0.8),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
