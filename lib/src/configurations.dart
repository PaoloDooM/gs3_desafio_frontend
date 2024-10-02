import 'package:flutter_dotenv/flutter_dotenv.dart';

enum SecureStorageKeys { token, rememberEmail, darkMode }

enum LoadingStatus { loaded, error, loading, idle }

class Configurations {
  static String get baseUrl => dotenv.env['BASEURL']!;
  static String get secureStorageAccount => dotenv.env['SECURESTORAGEACCOUNT']!;
  static String get secureStoragePublicKey =>
      dotenv.env['SECURESTORAGEPUBLICKEY']!;
}
