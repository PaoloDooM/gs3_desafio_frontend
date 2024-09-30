import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:gs3_desafio_front/src/apis/http_api_client.dart';
import 'package:gs3_desafio_front/src/configurations.dart';
import 'package:gs3_desafio_front/ui/pages/login_page.dart';
import 'package:gs3_desafio_front/ui/stores/configuration_store.dart';
import 'package:gs3_desafio_front/ui/stores/user_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  GetIt.I.registerLazySingleton<FlutterSecureStorage>(
    () => FlutterSecureStorage(
      aOptions: AndroidOptions(
        preferencesKeyPrefix: Configurations.secureStorageAccount,
        encryptedSharedPreferences: false,
      ),
      iOptions: IOSOptions(
        accountName: Configurations.secureStorageAccount,
        accessibility: KeychainAccessibility.first_unlock,
      ),
      webOptions: WebOptions(
        dbName: Configurations.secureStorageAccount,
        publicKey: Configurations.secureStoragePublicKey,
      ),
    ),
  );
  GetIt.I.registerLazySingleton<ConfigurationStore>(() => ConfigurationStore());
  GetIt.I.registerLazySingleton<UserStore>(() => UserStore());
  GetIt.I.registerLazySingleton<HttpApiClient>(() => HttpApiClient());

  await GetIt.I.allReady();

  runApp(const MyApp());
}

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return MaterialApp(
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown
          },
        ),
        title: 'GS3 desafio',
        scaffoldMessengerKey: snackbarKey,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: GetIt.I<ConfigurationStore>().theme,
        home: const LoginPage(),
      );
    });
  }
}
