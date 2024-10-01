// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PhonePageStore on PhonePageBase, Store {
  Computed<String>? _$searchStringComputed;

  @override
  String get searchString =>
      (_$searchStringComputed ??= Computed<String>(() => super.searchString,
              name: 'PhonePageBase.searchString'))
          .value;
  Computed<ObservableList<TelephoneNumberModel>>? _$phoneNumbersComputed;

  @override
  ObservableList<TelephoneNumberModel> get phoneNumbers =>
      (_$phoneNumbersComputed ??=
              Computed<ObservableList<TelephoneNumberModel>>(
                  () => super.phoneNumbers,
                  name: 'PhonePageBase.phoneNumbers'))
          .value;
  Computed<ObservableList<TelephoneNumberModel>>?
      _$filteredPhoneNumbersComputed;

  @override
  ObservableList<TelephoneNumberModel> get filteredPhoneNumbers =>
      (_$filteredPhoneNumbersComputed ??=
              Computed<ObservableList<TelephoneNumberModel>>(
                  () => super.filteredPhoneNumbers,
                  name: 'PhonePageBase.filteredPhoneNumbers'))
          .value;

  late final _$_searchStringAtom =
      Atom(name: 'PhonePageBase._searchString', context: context);

  @override
  String get _searchString {
    _$_searchStringAtom.reportRead();
    return super._searchString;
  }

  @override
  set _searchString(String value) {
    _$_searchStringAtom.reportWrite(value, super._searchString, () {
      super._searchString = value;
    });
  }

  late final _$_phoneNumbersAtom =
      Atom(name: 'PhonePageBase._phoneNumbers', context: context);

  @override
  ObservableList<TelephoneNumberModel> get _phoneNumbers {
    _$_phoneNumbersAtom.reportRead();
    return super._phoneNumbers;
  }

  @override
  set _phoneNumbers(ObservableList<TelephoneNumberModel> value) {
    _$_phoneNumbersAtom.reportWrite(value, super._phoneNumbers, () {
      super._phoneNumbers = value;
    });
  }

  late final _$setSearchStringAsyncAction =
      AsyncAction('PhonePageBase.setSearchString', context: context);

  @override
  Future<dynamic> setSearchString(String searchString) {
    return _$setSearchStringAsyncAction
        .run(() => super.setSearchString(searchString));
  }

  late final _$PhonePageBaseActionController =
      ActionController(name: 'PhonePageBase', context: context);

  @override
  dynamic setPhoneNumbers(List<TelephoneNumberModel> phoneNumbers) {
    final _$actionInfo = _$PhonePageBaseActionController.startAction(
        name: 'PhonePageBase.setPhoneNumbers');
    try {
      return super.setPhoneNumbers(phoneNumbers);
    } finally {
      _$PhonePageBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
searchString: ${searchString},
phoneNumbers: ${phoneNumbers},
filteredPhoneNumbers: ${filteredPhoneNumbers}
    ''';
  }
}
