import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gs3_desafio_front/src/services/configuration_service.dart';
import 'package:mobx/mobx.dart';

import '../../src/models/profile_model.dart';

part 'configuration_store.g.dart';

class ConfigurationStore = ConfigurationStoreBase with _$ConfigurationStore;

abstract class ConfigurationStoreBase with Store {
  final ThemeData lightTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff45a1e7), brightness: Brightness.light),
      useMaterial3: false);
  final ThemeData darkTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff45a1e7), brightness: Brightness.dark),
      useMaterial3: false);

  @observable
  bool _darkMode =
      PlatformDispatcher.instance.platformBrightness == Brightness.dark;

  @computed
  bool get darkMode => _darkMode;

  @computed
  ThemeData get theme => _darkMode ? darkTheme : lightTheme;

  @action
  Future setDarkMode(bool darkMode) async {
    _darkMode = darkMode;
    await ConfigurationService.setDarkMode(_darkMode);
  }

  Future toggleDarkMode() async {
    await setDarkMode(!_darkMode);
  }

  @action
  Future<bool> loadDarkModeFromStorage() async {
    _darkMode = await ConfigurationService.getDarkMode() ??
        PlatformDispatcher.instance.platformBrightness == Brightness.dark;
    return _darkMode;
  }

  @observable
  ObservableList<ProfileModel> _userProfiles = ObservableList.of([]);

  @computed
  ObservableList<ProfileModel> get userProfiles => _userProfiles;

  @action
  setUserProfiles(List<ProfileModel> userProfiles) {
    _userProfiles = ObservableList.of(userProfiles);
  }
}
