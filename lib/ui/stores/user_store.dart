import 'package:mobx/mobx.dart';

import '../../src/models/user_model.dart';
import '../../src/services/user_service.dart';

part 'user_store.g.dart';

class UserStore = UserStoreBase with _$UserStore;

abstract class UserStoreBase with Store {
  @observable
  String? _apiToken;

  @computed
  String? get apiToken => _apiToken;

  @action
  Future setApiToken(String? apiToken) async {
    _apiToken = apiToken;
    await UserService.setApiToken(_apiToken);
  }

  @action
  Future<String?> loadApiTokenFromStorage() async {
    _apiToken = await UserService.getApiToken();
    return _apiToken;
  }

  @observable
  UserModel? _user;

  @computed
  UserModel? get user => _user;

  @action
  setUser(UserModel? user) {
    _user = user;
  }
}
