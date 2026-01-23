import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl_standalone.dart';

import 'core/di/injection_container.dart' as di;
import 'core/theme/app_theme.dart';
import 'features/settings/presentation/cubit/settings_cubit.dart';
import 'features/settings/presentation/cubit/settings_state.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  await findSystemLocale();
  await di.initialize();
  runApp(const MuscleupApp());
}

class MuscleupApp extends StatelessWidget {
  const MuscleupApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = di.serviceLocator<GoRouter>();
    final settingsCubit = di.serviceLocator<SettingsCubit>();

    return BlocProvider.value(
      value: settingsCubit,
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return MaterialApp.router(
            routerConfig: router,
            title: 'Muscleup',
            debugShowCheckedModeBanner: false,
            locale: state.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en'), Locale('es')],
            theme: AppTheme.getTheme(
              skin: state.currentSkin,
              isDarkMode: false,
            ),
            darkTheme: AppTheme.getTheme(
              skin: state.currentSkin,
              isDarkMode: true,
            ),
            themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          );
        },
      ),
    );
  }
}
