import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  runApp(const MuscleupBootstrap());
}

class MuscleupBootstrap extends StatefulWidget {
  const MuscleupBootstrap({super.key});

  @override
  State<MuscleupBootstrap> createState() => _MuscleupBootstrapState();
}

class _MuscleupBootstrapState extends State<MuscleupBootstrap> {
  late final Future<void> _startupFuture;

  @override
  void initState() {
    super.initState();
    _startupFuture = _initializeApp();
  }

  Future<void> _initializeApp() async {
    await initializeDateFormatting();
    await findSystemLocale();
    await di.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _startupFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const MuscleupApp();
        }

        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: _StartupSplashScreen(),
        );
      },
    );
  }
}

class _StartupSplashScreen extends StatelessWidget {
  const _StartupSplashScreen();

  static const String _assetPath = 'assets/muscleup_splash.svg';

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: SizedBox(
          width: 220,
          height: 220,
          child: SvgPicture.asset(
            _assetPath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
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
