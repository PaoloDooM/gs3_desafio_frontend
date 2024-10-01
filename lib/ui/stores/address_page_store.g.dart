// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddressPageStore on AddressPageBase, Store {
  Computed<String>? _$searchStringComputed;

  @override
  String get searchString =>
      (_$searchStringComputed ??= Computed<String>(() => super.searchString,
              name: 'AddressPageBase.searchString'))
          .value;
  Computed<ObservableList<AddressModel>>? _$addressesComputed;

  @override
  ObservableList<AddressModel> get addresses => (_$addressesComputed ??=
          Computed<ObservableList<AddressModel>>(() => super.addresses,
              name: 'AddressPageBase.addresses'))
      .value;
  Computed<ObservableList<AddressModel>>? _$filteredAddressesComputed;

  @override
  ObservableList<AddressModel> get filteredAddresses =>
      (_$filteredAddressesComputed ??= Computed<ObservableList<AddressModel>>(
              () => super.filteredAddresses,
              name: 'AddressPageBase.filteredAddresses'))
          .value;

  late final _$_searchStringAtom =
      Atom(name: 'AddressPageBase._searchString', context: context);

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

  late final _$_addressesAtom =
      Atom(name: 'AddressPageBase._addresses', context: context);

  @override
  ObservableList<AddressModel> get _addresses {
    _$_addressesAtom.reportRead();
    return super._addresses;
  }

  @override
  set _addresses(ObservableList<AddressModel> value) {
    _$_addressesAtom.reportWrite(value, super._addresses, () {
      super._addresses = value;
    });
  }

  late final _$setSearchStringAsyncAction =
      AsyncAction('AddressPageBase.setSearchString', context: context);

  @override
  Future<dynamic> setSearchString(String searchString) {
    return _$setSearchStringAsyncAction
        .run(() => super.setSearchString(searchString));
  }

  late final _$AddressPageBaseActionController =
      ActionController(name: 'AddressPageBase', context: context);

  @override
  dynamic setAddresses(List<AddressModel> addresses) {
    final _$actionInfo = _$AddressPageBaseActionController.startAction(
        name: 'AddressPageBase.setAddresses');
    try {
      return super.setAddresses(addresses);
    } finally {
      _$AddressPageBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
searchString: ${searchString},
addresses: ${addresses},
filteredAddresses: ${filteredAddresses}
    ''';
  }
}
