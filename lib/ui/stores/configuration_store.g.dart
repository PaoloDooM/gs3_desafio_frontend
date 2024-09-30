// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ConfigurationStore on ConfigurationStoreBase, Store {
  Computed<bool>? _$darkModeComputed;

  @override
  bool get darkMode =>
      (_$darkModeComputed ??= Computed<bool>(() => super.darkMode,
              name: 'ConfigurationStoreBase.darkMode'))
          .value;
  Computed<ThemeData>? _$themeComputed;

  @override
  ThemeData get theme =>
      (_$themeComputed ??= Computed<ThemeData>(() => super.theme,
              name: 'ConfigurationStoreBase.theme'))
          .value;

  late final _$_darkModeAtom =
      Atom(name: 'ConfigurationStoreBase._darkMode', context: context);

  @override
  bool get _darkMode {
    _$_darkModeAtom.reportRead();
    return super._darkMode;
  }

  @override
  set _darkMode(bool value) {
    _$_darkModeAtom.reportWrite(value, super._darkMode, () {
      super._darkMode = value;
    });
  }

  late final _$setDarkModeAsyncAction =
      AsyncAction('ConfigurationStoreBase.setDarkMode', context: context);

  @override
  Future<dynamic> setDarkMode(bool darkMode) {
    return _$setDarkModeAsyncAction.run(() => super.setDarkMode(darkMode));
  }

  late final _$loadDarkModeFromStorageAsyncAction = AsyncAction(
      'ConfigurationStoreBase.loadDarkModeFromStorage',
      context: context);

  @override
  Future<dynamic> loadDarkModeFromStorage() {
    return _$loadDarkModeFromStorageAsyncAction
        .run(() => super.loadDarkModeFromStorage());
  }

  @override
  String toString() {
    return '''
darkMode: ${darkMode},
theme: ${theme}
    ''';
  }
}
