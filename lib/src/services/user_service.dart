import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:gs3_desafio_front/src/apis/user_api.dart';
import 'package:gs3_desafio_front/ui/stores/user_store.dart';
import '../../main.dart';
import '../../ui/pages/login_page.dart';
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
      await GetIt.I<UserStore>()
          .setApiToken(await UserApi.login(email, password));
      if (rememberEmail) {
        await setRememberedEmail(email);
      }
      snackbarKey.currentState?.clearSnackBars();
    } catch (e) {
      snackbarKey.currentState
        ?..clearSnackBars()
        ..showSnackBar(SnackBar(
            content: Text(
              "$e",
              style: TextStyle(
                  color:
                      GetIt.I<ConfigurationStore>().theme.colorScheme.onError),
            ),
            duration: const Duration(seconds: 12),
            backgroundColor:
                GetIt.I<ConfigurationStore>().theme.colorScheme.error));
    }
  }

  static Future logout() async {
    await GetIt.I<UserStore>().setApiToken(null);
    navigatorKey.currentState?.pushReplacement(MaterialPageRoute<void>(
      builder: (BuildContext context) => const LoginPage(),
    ));
    GetIt.I<UserStore>().setUser(null);
  }

  static Future getLoggedUser() async {
    GetIt.I<UserStore>().setUser(await UserApi.getLoggedUser());
  }

  static Future setApiToken(String? apiToken) async {
    await GetIt.I<FlutterSecureStorage>()
        .write(key: SecureStorageKeys.token.name, value: apiToken);
  }

  static Future<String?> getApiToken() async {
    return await GetIt.I<FlutterSecureStorage>()
        .read(key: SecureStorageKeys.token.name);
  }

  static Future deleteApiToken() async {
    return await GetIt.I<FlutterSecureStorage>()
        .delete(key: SecureStorageKeys.token.name);
  }

  static Future setRememberedEmail(String rememberedEmail) async {
    await GetIt.I<FlutterSecureStorage>().write(
        key: SecureStorageKeys.rememberEmail.name, value: rememberedEmail);
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
