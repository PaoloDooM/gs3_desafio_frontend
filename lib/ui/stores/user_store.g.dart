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

  late final _$UserStoreBaseActionController =
      ActionController(name: 'UserStoreBase', context: context);

  @override
  dynamic setApiToken(String? apiToken) {
    final _$actionInfo = _$UserStoreBaseActionController.startAction(
        name: 'UserStoreBase.setApiToken');
    try {
      return super.setApiToken(apiToken);
    } finally {
      _$UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
apiToken: ${apiToken}
    ''';
  }
}
