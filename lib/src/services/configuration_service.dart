import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:gs3_desafio_front/src/configurations.dart';

class ConfigurationService {
  static Future<bool?> getDarkMode() async {
    return bool.tryParse(
        await GetIt.I<FlutterSecureStorage>()
                .read(key: SecureStorageKeys.darkMode.name) ??
            "",
        caseSensitive: false);
  }

  static Future setDarkMode(bool darkMode) async {
    await GetIt.I<FlutterSecureStorage>().write(
        key: SecureStorageKeys.darkMode.name, value: darkMode.toString());
  }
}
