import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/theme/app_theme.dart';

part 'settings_state.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    required Locale locale,
    required AppSkin currentSkin,
    required bool isDarkMode,
  }) = _SettingsState;
}
