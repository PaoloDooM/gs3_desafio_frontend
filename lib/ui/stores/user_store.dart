import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import '../../main.dart';
import '../../src/models/user_model.dart';
import '../../src/services/user_service.dart';
import 'configuration_store.dart';

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

  Future refreshUser() async {
    try {
      await UserService.getLoggedUser();
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
}
