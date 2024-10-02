import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gs3_desafio_front/src/apis/http_api_client.dart';
import 'package:gs3_desafio_front/src/apis/user_api.dart';
import 'package:gs3_desafio_front/ui/stores/users_page_store.dart';
import 'package:gs3_desafio_front/ui/widgets/user_form.dart';
import 'package:gs3_desafio_front/ui/widgets/user_header.dart';
import '../../main.dart';
import '../../src/models/user_model.dart';
import '../pages/addresses_page.dart';
import '../pages/phones_page.dart';
import '../stores/address_page_store.dart';
import '../stores/phone_page_store.dart';
import 'custom_form.dart';
import 'dialog_form.dart';

class UserDetails extends StatelessWidget {
  final UserModel? user;
  final ThemeData theme;
  final bool listTile;
  final GlobalKey<RefreshIndicatorState>? refreshKey;
  final UsersPageStore? usersStrore;

  const UserDetails(
      {super.key,
      required this.user,
      required this.theme,
      this.listTile = false,
      this.refreshKey,
      this.usersStrore});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      InkWell(
        onTap: listTile
            ? null
            : () {
                openUserForm(context);
              },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: listTile ? 16 : 32.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UserHeader(user, Axis.horizontal),
              Visibility(
                visible: !listTile,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: () {
                        openUserForm(context);
                      },
                      icon: Icon(
                        Icons.edit,
                        color: theme.colorScheme.tertiary,
                      )),
                ),
              )
            ],
          ),
        ),
      ),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(children: [
            Visibility(
              visible: !listTile,
              child: Column(
                children: [
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("User information")),
                  Divider(color: theme.colorScheme.secondary),
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 8, top: listTile ? 0 : 16, right: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                    text: TextSpan(
                        text: "Email: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onBackground),
                        children: [
                      TextSpan(
                          text: user?.email ?? "",
                          style:
                              const TextStyle(fontWeight: FontWeight.normal)),
                    ])),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 10, right: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                      text: "CPF: ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onBackground),
                      children: [
                        TextSpan(
                            text: user?.cpf ?? "",
                            style:
                                const TextStyle(fontWeight: FontWeight.normal))
                      ]),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 8, top: 16, right: 8),
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  AddressPageStore addressStore =
                      AddressPageStore(user?.addresses ?? []);
                  navigatorKey.currentState?.push(MaterialPageRoute<void>(
                    builder: (BuildContext context) => AddressesPage(
                        user: user,
                        addressesStore: addressStore,
                        refreshAddresses: () async {
                          await addressStore.refreshAddresses(
                              user: listTile ? user : null);
                          if (listTile) {
                            usersStrore?.addAddresses(
                                user?.id,
                                addressStore.addresses,
                                () async => await refreshKey?.currentState
                                    ?.show(atTop: false));
                          }
                        }),
                  ));
                },
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                      BorderSide(color: theme.colorScheme.primary, width: 2)),
                ),
                child: const Text("Addresses",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 8, top: 2, right: 8),
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  PhonePageStore phoneStore =
                      PhonePageStore(user?.telephoneNumbers ?? []);
                  navigatorKey.currentState?.push(MaterialPageRoute<void>(
                    builder: (BuildContext context) => PhonesPage(
                        user: user,
                        phonesStore: phoneStore,
                        refreshPhones: () async {
                          await phoneStore.refreshPhoneNumbers(
                              user: listTile ? user : null);
                          if (listTile) {
                            usersStrore?.addPhoneNumbers(
                                user?.id,
                                phoneStore.phoneNumbers,
                                () async => await refreshKey?.currentState
                                    ?.show(atTop: false));
                          }
                        }),
                  ));
                },
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                      BorderSide(color: theme.colorScheme.primary, width: 2)),
                ),
                child: const Text(
                  "Phone numbers",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
          ]))
    ]);
  }

  openUserForm(BuildContext context) {
    GlobalKey<CustomFormState> formKey = GlobalKey<CustomFormState>();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        CancelToken token = CancelToken();
        return DialogForm(
          title: "Edit user",
          formKeys: [formKey],
          onAccept: () async {
            UserModel? editedUser = formKey.currentState?.submit();
            if (editedUser != null) {
              await UserApi.updateUser(editedUser, cancelToken: token);
              if (context.mounted) {
                Navigator.of(context).pop();
              }
              refreshKey?.currentState?.show(atTop: false);
            }
          },
          onCancel: () async {
            GetIt.I<HttpApiClient>().cancelRequest(token);
          },
          children: [
            UserForm(
              key: formKey,
              user: user,
            )
          ],
        );
      },
    );
  }
}
