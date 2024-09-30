import 'package:mobx/mobx.dart';

import '../../src/services/user_service.dart';

part 'user_store.g.dart';

class UserStore = UserStoreBase with _$UserStore;

abstract class UserStoreBase with Store {
  @observable
  String? _apiToken;

  @computed
  String? get apiToken => _apiToken;

  @action
  setApiToken(String? apiToken) => _apiToken = apiToken;

  @action
  Future loadApiTokenFromStorage() async {
    _apiToken = await UserService.getApiToken();
  }
}
