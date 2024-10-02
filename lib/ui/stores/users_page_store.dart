import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gs3_desafio_front/src/configurations.dart';
import 'package:mobx/mobx.dart';
import '../../main.dart';
import '../../src/apis/user_api.dart';
import '../../src/models/address_model.dart';
import '../../src/models/profile_model.dart';
import '../../src/models/telephone_number_model.dart';
import '../../src/models/user_model.dart';
import 'configuration_store.dart';

part 'users_page_store.g.dart';

class UsersPageStore = UsersPageBase with _$UsersPageStore;

abstract class UsersPageBase with Store {
  @observable
  LoadingStatus _loadingStatus = LoadingStatus.idle;

  @computed
  LoadingStatus get loadingStatus => _loadingStatus;

  @action
  Future setLoadingStatus(LoadingStatus loadingStatus) async {
    _loadingStatus = loadingStatus;
  }

  @observable
  String _searchString = "";

  @computed
  String get searchString => _searchString;

  @action
  Future setSearchString(String searchString) async {
    _searchString = searchString;
  }

  @observable
  ProfileModel? _profile;

  @computed
  ProfileModel? get profile => _profile;

  @action
  Future setProfile(ProfileModel? profile) async {
    _profile = profile;
  }

  @observable
  ObservableList<UserModel> _users = ObservableList.of([]);

  @computed
  ObservableList<UserModel> get users => _users;

  @action
  setUsers(List<UserModel> users) {
    _users = ObservableList.of(users);
  }

  Future refreshUsers() async {
    try {
      snackbarKey.currentState?.clearSnackBars();
      setLoadingStatus(LoadingStatus.loading);
      _users = ObservableList.of(await UserApi.getUsers());
      setLoadingStatus(LoadingStatus.loaded);
    } catch (e) {
      setLoadingStatus(LoadingStatus.error);
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

  @computed
  ObservableList<UserModel> get filteredUsers {
    String searchString = _searchString;
    return ObservableList.of(
        (searchString.isEmpty ? _users : searchUsers(searchString)).where(
            (element) =>
                element.profile.id == (profile?.id ?? -1) ||
                (profile?.id ?? -1) == -1));
  }

  ObservableList<UserModel> searchUsers(String searchString) {
    List<MapEntry<int, UserModel>> users = [];
    for (UserModel user in _users) {
      int matches = 0;
      for (String word in searchString.trim().split(" ")) {
        if (user.name.toLowerCase().contains(word.toLowerCase())) {
          matches++;
        }
        if (user.email.toLowerCase().contains(word.toLowerCase())) {
          matches++;
        }
        if (user.cpf.toLowerCase().contains(word.toLowerCase())) {
          matches++;
        }
      }
      if (matches > 0) {
        users.add(MapEntry(matches, user));
      }
    }
    users.sort((a, b) => b.key - a.key);
    return ObservableList.of(users.map((e) => e.value));
  }

  @action
  Future addAddresses(userId, ObservableList<AddressModel> addresses,
      Future Function() onError) async {
    try {
      _users[_users.indexWhere((element) => element.id == userId)].addresses =
          addresses;
    } catch (e) {
      await onError();
    }
  }

  @action
  Future addPhoneNumbers(
      userId,
      ObservableList<TelephoneNumberModel> phoneNumbers,
      Future Function() onError) async {
    try {
      _users[_users.indexWhere((element) => element.id == userId)]
          .telephoneNumbers = phoneNumbers;
    } catch (e) {
      await onError();
    }
  }
}
