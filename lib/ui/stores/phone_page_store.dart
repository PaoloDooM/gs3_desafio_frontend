import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gs3_desafio_front/ui/stores/user_store.dart';
import 'package:mobx/mobx.dart';
import '../../main.dart';
import '../../src/models/telephone_number_model.dart';
import '../../src/services/user_service.dart';
import 'configuration_store.dart';

part 'phone_page_store.g.dart';

class PhonePageStore = PhonePageBase with _$PhonePageStore;

abstract class PhonePageBase with Store {
  PhonePageBase(List<TelephoneNumberModel> phoneNumbers) {
    _phoneNumbers = ObservableList.of(phoneNumbers);
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
  ObservableList<TelephoneNumberModel> _phoneNumbers = ObservableList.of([]);

  @computed
  ObservableList<TelephoneNumberModel> get phoneNumbers => _phoneNumbers;

  @action
  setPhoneNumbers(List<TelephoneNumberModel> phoneNumbers) {
    _phoneNumbers = ObservableList.of(phoneNumbers);
  }

  Future refreshPhoneNumbers() async {
    try {
      await UserService.getLoggedUser();
      setPhoneNumbers(GetIt.I<UserStore>().user!.telephoneNumbers);
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
  ObservableList<TelephoneNumberModel> get filteredPhoneNumbers {
    String searchString = _searchString;
    if (searchString.isEmpty) {
      ObservableList<TelephoneNumberModel> sortedPhoneNumbers =
          ObservableList.of(_phoneNumbers);
      sortedPhoneNumbers
          .sort((a, b) => (b.principal ? 1 : 0).compareTo(a.principal ? 1 : 0));
      return sortedPhoneNumbers;
    } else {
      return searchPhoneNumbers(searchString);
    }
  }

  ObservableList<TelephoneNumberModel> searchPhoneNumbers(String searchString) {
    List<MapEntry<int, TelephoneNumberModel>> phoneNumbers = [];
    for (TelephoneNumberModel phoneNumber in _phoneNumbers) {
      int matches = 0;
      for (String word in searchString.trim().split(" ")) {
        if (phoneNumber.number.toLowerCase().contains(word.toLowerCase())) {
          matches++;
        }
        if (phoneNumber.description
            .toLowerCase()
            .contains(word.toLowerCase())) {
          matches++;
        }
      }
      if (matches > 0) {
        phoneNumbers.add(MapEntry(matches, phoneNumber));
      }
    }
    phoneNumbers.sort((a, b) => b.key - a.key);
    return ObservableList.of(phoneNumbers.map((e) => e.value));
  }
}
