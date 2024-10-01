import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:gs3_desafio_front/src/apis/user_api.dart';
import 'package:gs3_desafio_front/src/configurations.dart';
import 'package:gs3_desafio_front/ui/stores/configuration_store.dart';
import 'package:gs3_desafio_front/ui/stores/user_store.dart';

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

  static Future getProfiles() async {
    if (GetIt.I<UserStore>().user?.profile.label.toLowerCase() == 'admin') {
      GetIt.I<ConfigurationStore>()
          .setUserProfiles(await UserApi.getProfiles());
    }else{
      GetIt.I<ConfigurationStore>()
          .setUserProfiles([]);
    }
  }
}
