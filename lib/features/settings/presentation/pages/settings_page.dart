import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/l10n_extension.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../auth/presentation/cubit/auth_state.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';
import '../cubit/sync_status_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: serviceLocator<AuthCubit>()),
        BlocProvider.value(value: serviceLocator<SettingsCubit>()),
        BlocProvider.value(value: serviceLocator<SyncStatusCubit>()),
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
        title: Text(context.l10n.settings),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingMedium),
        children: const [
          _AccountSection(),
          _DividerSection(),
          _SyncSection(),
          _DividerSection(),
          _AppearanceSection(),
          _DividerSection(),
          _LanguageSection(),
        ],
      ),
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.authLinkSuccess)),
      );
      return;
    }

    if (state is AuthError) {
      final rawMessage = state.message;
      final message = rawMessage.startsWith('Exception: ')
          ? rawMessage.substring('Exception: '.length)
          : rawMessage;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
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

        return BlocBuilder<SyncStatusCubit, SyncStatusState>(
          builder: (context, syncStatusState) {
            final lastRunMetrics = syncStatusState.lastRunMetrics;
            final lastSyncLabel = lastRunMetrics == null
                ? 'Never synced'
                : DateFormat('yyyy-MM-dd HH:mm:ss').format(lastRunMetrics.endedAt);

            final syncSummary = lastRunMetrics == null
                ? 'No sync metrics available yet'
                : 'Pushed ${lastRunMetrics.pushedCount} | Pulled ${lastRunMetrics.pulledCount} | Conflicts ${lastRunMetrics.conflictsResolvedCount} | Failed ${lastRunMetrics.failedCount}';

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SectionHeader('CLOUD SYNC'),
                ListTile(
                  leading: Icon(
                    syncStatusState.isSyncing
                        ? Icons.sync_rounded
                        : (cloudSyncEnabled
                            ? Icons.cloud_done_rounded
                            : Icons.cloud_off_rounded),
                  ),
                  title: Text(
                    syncStatusState.isSyncing
                        ? 'Syncing...'
                        : (cloudSyncEnabled ? 'Sync status' : 'Cloud sync locked'),
                  ),
                  subtitle: Text(
                    cloudSyncEnabled
                        ? 'Last sync: $lastSyncLabel\n$syncSummary'
                        : 'Link your Google account to enable cloud sync',
                  ),
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
                      onPressed: (!cloudSyncEnabled || syncStatusState.isSyncing)
                          ? null
                          : context.read<SyncStatusCubit>().syncNow,
                      icon: const Icon(Icons.sync),
                      label: const Text('Sync now'),
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

  String _languageLabel(String code) {
    switch (code) {
      case 'es':
        return 'Español';
      case 'en':
      default:
        return 'English';
    }
  }

  void _showLanguageSelector(BuildContext context, String currentCode) {
    final settingsCubit = context.read<SettingsCubit>();
    const options = [
      ('en', 'English'),
      ('es', 'Español'),
    ];

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
                  context.l10n.language,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 16),
              ...options.map((option) {
                final code = option.$1;
                final label = option.$2;
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
              }),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}
