// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UsersPageStore on UsersPageBase, Store {
  Computed<LoadingStatus>? _$loadingStatusComputed;

  @override
  LoadingStatus get loadingStatus => (_$loadingStatusComputed ??=
          Computed<LoadingStatus>(() => super.loadingStatus,
              name: 'UsersPageBase.loadingStatus'))
      .value;
  Computed<String>? _$searchStringComputed;

  @override
  String get searchString =>
      (_$searchStringComputed ??= Computed<String>(() => super.searchString,
              name: 'UsersPageBase.searchString'))
          .value;
  Computed<ProfileModel?>? _$profileComputed;

  @override
  ProfileModel? get profile =>
      (_$profileComputed ??= Computed<ProfileModel?>(() => super.profile,
              name: 'UsersPageBase.profile'))
          .value;
  Computed<ObservableList<UserModel>>? _$usersComputed;

  @override
  ObservableList<UserModel> get users => (_$usersComputed ??=
          Computed<ObservableList<UserModel>>(() => super.users,
              name: 'UsersPageBase.users'))
      .value;
  Computed<ObservableList<UserModel>>? _$filteredUsersComputed;

  @override
  ObservableList<UserModel> get filteredUsers => (_$filteredUsersComputed ??=
          Computed<ObservableList<UserModel>>(() => super.filteredUsers,
              name: 'UsersPageBase.filteredUsers'))
      .value;

  late final _$_loadingStatusAtom =
      Atom(name: 'UsersPageBase._loadingStatus', context: context);

  @override
  LoadingStatus get _loadingStatus {
    _$_loadingStatusAtom.reportRead();
    return super._loadingStatus;
  }

  @override
  set _loadingStatus(LoadingStatus value) {
    _$_loadingStatusAtom.reportWrite(value, super._loadingStatus, () {
      super._loadingStatus = value;
    });
  }

  late final _$_searchStringAtom =
      Atom(name: 'UsersPageBase._searchString', context: context);

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

  late final _$_profileAtom =
      Atom(name: 'UsersPageBase._profile', context: context);

  @override
  ProfileModel? get _profile {
    _$_profileAtom.reportRead();
    return super._profile;
  }

  @override
  set _profile(ProfileModel? value) {
    _$_profileAtom.reportWrite(value, super._profile, () {
      super._profile = value;
    });
  }

  late final _$_usersAtom =
      Atom(name: 'UsersPageBase._users', context: context);

  @override
  ObservableList<UserModel> get _users {
    _$_usersAtom.reportRead();
    return super._users;
  }

  @override
  set _users(ObservableList<UserModel> value) {
    _$_usersAtom.reportWrite(value, super._users, () {
      super._users = value;
    });
  }

  late final _$setLoadingStatusAsyncAction =
      AsyncAction('UsersPageBase.setLoadingStatus', context: context);

  @override
  Future<dynamic> setLoadingStatus(LoadingStatus loadingStatus) {
    return _$setLoadingStatusAsyncAction
        .run(() => super.setLoadingStatus(loadingStatus));
  }

  late final _$setSearchStringAsyncAction =
      AsyncAction('UsersPageBase.setSearchString', context: context);

  @override
  Future<dynamic> setSearchString(String searchString) {
    return _$setSearchStringAsyncAction
        .run(() => super.setSearchString(searchString));
  }

  late final _$setProfileAsyncAction =
      AsyncAction('UsersPageBase.setProfile', context: context);

  @override
  Future<dynamic> setProfile(ProfileModel? profile) {
    return _$setProfileAsyncAction.run(() => super.setProfile(profile));
  }

  late final _$addAddressesAsyncAction =
      AsyncAction('UsersPageBase.addAddresses', context: context);

  @override
  Future<dynamic> addAddresses(
      dynamic userId,
      ObservableList<AddressModel> addresses,
      Future<dynamic> Function() onError) {
    return _$addAddressesAsyncAction
        .run(() => super.addAddresses(userId, addresses, onError));
  }

  late final _$addPhoneNumbersAsyncAction =
      AsyncAction('UsersPageBase.addPhoneNumbers', context: context);

  @override
  Future<dynamic> addPhoneNumbers(
      dynamic userId,
      ObservableList<TelephoneNumberModel> phoneNumbers,
      Future<dynamic> Function() onError) {
    return _$addPhoneNumbersAsyncAction
        .run(() => super.addPhoneNumbers(userId, phoneNumbers, onError));
  }

  late final _$UsersPageBaseActionController =
      ActionController(name: 'UsersPageBase', context: context);

  @override
  dynamic setUsers(List<UserModel> users) {
    final _$actionInfo = _$UsersPageBaseActionController.startAction(
        name: 'UsersPageBase.setUsers');
    try {
      return super.setUsers(users);
    } finally {
      _$UsersPageBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loadingStatus: ${loadingStatus},
searchString: ${searchString},
profile: ${profile},
users: ${users},
filteredUsers: ${filteredUsers}
    ''';
  }
}
