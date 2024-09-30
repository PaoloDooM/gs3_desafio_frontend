import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:gs3_desafio_front/src/apis/user_api.dart';
import '../../main.dart';
import '../../ui/stores/configuration_store.dart';
import '../configurations.dart';

class UserService {
  static Future login(String email, String password, bool rememberEmail) async {
    snackbarKey.currentState
      ?..clearSnackBars()
      ..showSnackBar(const SnackBar(
        content: Text("logging in"),
        duration: Duration(days: 1),
      ));
    try {
      await GetIt.I<FlutterSecureStorage>().write(
          key: SecureStorageKeys.token.name,
          value: await UserApi.login(email, password));
      if (rememberEmail) {
        await GetIt.I<FlutterSecureStorage>()
            .write(key: SecureStorageKeys.rememberEmail.name, value: email);
      }
      snackbarKey.currentState?.clearSnackBars();
      ///TODO: Navigate home
    } catch (e) {
      snackbarKey.currentState
        ?..clearSnackBars()
        ..showSnackBar(SnackBar(
            content: Text("$e"),
            duration: const Duration(seconds: 12),
            backgroundColor:
                GetIt.I<ConfigurationStore>().theme.colorScheme.error));
    }
  }

  static Future<String?> getApiToken() async {
    return await GetIt.I<FlutterSecureStorage>()
        .read(key: SecureStorageKeys.token.name);
  }

  static Future deleteApiToken() async {
    return await GetIt.I<FlutterSecureStorage>()
        .delete(key: SecureStorageKeys.token.name);
  }

  static Future<String?> getRememberedEmail() async {
    return await GetIt.I<FlutterSecureStorage>()
        .read(key: SecureStorageKeys.rememberEmail.name);
  }

  static Future deleteRememberedEmail() async {
    await GetIt.I<FlutterSecureStorage>()
        .delete(key: SecureStorageKeys.rememberEmail.name);
  }
}
