import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gs3_desafio_front/ui/stores/user_store.dart';
import 'package:mobx/mobx.dart';
import '../../main.dart';
import '../../src/apis/user_api.dart';
import '../../src/models/address_model.dart';
import '../../src/models/user_model.dart';
import '../../src/services/user_service.dart';
import 'configuration_store.dart';

part 'address_page_store.g.dart';

class AddressPageStore = AddressPageBase with _$AddressPageStore;

abstract class AddressPageBase with Store {
  AddressPageBase(List<AddressModel> addresses) {
    _addresses = ObservableList.of(addresses);
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
  ObservableList<AddressModel> _addresses = ObservableList.of([]);

  @computed
  ObservableList<AddressModel> get addresses => _addresses;

  @action
  setAddresses(List<AddressModel> addresses) {
    _addresses = ObservableList.of(addresses);
  }

  Future refreshAddresses({UserModel? user}) async {
    try {
      if (user != null) {
        user = await UserApi.getUserById(user.id);
        setAddresses(user.addresses);
      } else {
        await UserService.getLoggedUser();
        setAddresses(GetIt.I<UserStore>().user!.addresses);
      }
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

  @computed
  ObservableList<AddressModel> get filteredAddresses {
    String searchString = _searchString;
    if (searchString.isEmpty) {
      ObservableList<AddressModel> sortedAddresses =
          ObservableList.of(_addresses);
      sortedAddresses
          .sort((a, b) => (b.principal ? 1 : 0).compareTo(a.principal ? 1 : 0));
      return sortedAddresses;
    } else {
      return searchAddresses(searchString);
    }
  }

  ObservableList<AddressModel> searchAddresses(String searchString) {
    List<MapEntry<int, AddressModel>> addresses = [];
    for (AddressModel address in _addresses) {
      int matches = 0;
      for (String word in searchString.trim().split(" ")) {
        if (address.address.toLowerCase().contains(word.toLowerCase())) {
          matches++;
        }
        if (address.description.toLowerCase().contains(word.toLowerCase())) {
          matches++;
        }
      }
      if (matches > 0) {
        addresses.add(MapEntry(matches, address));
      }
    }
    addresses.sort((a, b) => b.key - a.key);
    return ObservableList.of(addresses.map((e) => e.value));
  }
}
