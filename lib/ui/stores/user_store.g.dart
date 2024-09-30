// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on UserStoreBase, Store {
  Computed<String?>? _$apiTokenComputed;

  @override
  String? get apiToken =>
      (_$apiTokenComputed ??= Computed<String?>(() => super.apiToken,
              name: 'UserStoreBase.apiToken'))
          .value;
  Computed<UserModel?>? _$userComputed;

  @override
  UserModel? get user => (_$userComputed ??=
          Computed<UserModel?>(() => super.user, name: 'UserStoreBase.user'))
      .value;

  late final _$_apiTokenAtom =
      Atom(name: 'UserStoreBase._apiToken', context: context);

  @override
  String? get _apiToken {
    _$_apiTokenAtom.reportRead();
    return super._apiToken;
  }

  @override
  set _apiToken(String? value) {
    _$_apiTokenAtom.reportWrite(value, super._apiToken, () {
      super._apiToken = value;
    });
  }

  late final _$_userAtom = Atom(name: 'UserStoreBase._user', context: context);

  @override
  UserModel? get _user {
    _$_userAtom.reportRead();
    return super._user;
  }

  @override
  set _user(UserModel? value) {
    _$_userAtom.reportWrite(value, super._user, () {
      super._user = value;
    });
  }

  late final _$setApiTokenAsyncAction =
      AsyncAction('UserStoreBase.setApiToken', context: context);

  @override
  Future<dynamic> setApiToken(String? apiToken) {
    return _$setApiTokenAsyncAction.run(() => super.setApiToken(apiToken));
  }

  late final _$loadApiTokenFromStorageAsyncAction =
      AsyncAction('UserStoreBase.loadApiTokenFromStorage', context: context);

  @override
  Future<String?> loadApiTokenFromStorage() {
    return _$loadApiTokenFromStorageAsyncAction
        .run(() => super.loadApiTokenFromStorage());
  }

  late final _$UserStoreBaseActionController =
      ActionController(name: 'UserStoreBase', context: context);

  @override
  dynamic setUser(UserModel? user) {
    final _$actionInfo = _$UserStoreBaseActionController.startAction(
        name: 'UserStoreBase.setUser');
    try {
      return super.setUser(user);
    } finally {
      _$UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
apiToken: ${apiToken},
user: ${user}
    ''';
  }
}
