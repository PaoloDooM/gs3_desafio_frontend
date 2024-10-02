import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:gs3_desafio_front/main.dart';
import 'package:gs3_desafio_front/ui/stores/address_page_store.dart';
import 'package:gs3_desafio_front/ui/widgets/address_form.dart';
import 'package:gs3_desafio_front/ui/widgets/custom_form.dart';
import 'package:gs3_desafio_front/ui/widgets/detail_card.dart';
import '../../src/apis/http_api_client.dart';
import '../../src/apis/user_api.dart';
import '../../src/models/address_model.dart';
import '../../src/models/user_model.dart';
import '../../src/services/user_service.dart';
import '../stores/configuration_store.dart';
import '../widgets/dialog_form.dart';

class AddressesPage extends StatefulWidget {
  final UserModel? user;
  final AddressPageStore addressesStore;
  final Future<void> Function() refreshAddresses;

  const AddressesPage(
      {super.key,
      required this.addressesStore,
      required this.refreshAddresses,
      this.user});

  @override
  State<StatefulWidget> createState() => AddressesPageState();
}

class AddressesPageState extends State<AddressesPage> {
  ScrollController scrollBarController = ScrollController();
  TextEditingController searchController = TextEditingController();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void dispose() {
    searchController.dispose();
    scrollBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Addresses"),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              navigatorKey.currentState?.pop();
            }),
      ),
      body: Observer(
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: searchController,
                  onChanged: (String? value) {
                    widget.addressesStore.setSearchString(value ?? "");
                  },
                  decoration: InputDecoration(
                      label: const Text("Search"),
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                          onPressed: () {
                            widget.addressesStore.setSearchString("");
                            searchController.clear();
                          },
                          icon: const Icon(Icons.clear)),
                      border: const OutlineInputBorder()),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    RefreshIndicator(
                      key: _refreshKey,
                      onRefresh: () async {
                        await widget.refreshAddresses();
                      },
                      child: Scrollbar(
                        controller: scrollBarController,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 60),
                          controller: scrollBarController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount:
                              widget.addressesStore.filteredAddresses.length,
                          itemBuilder: (context, index) {
                            AddressModel address =
                                widget.addressesStore.filteredAddresses[index];
                            return DetailCard(
                              title: address.description,
                              delete: () async {
                                UserModel? user = widget.user;
                                if (user != null) {
                                  await UserApi.deleteAddressById(
                                      user.id, address);
                                } else {
                                  await UserService.deleteAddress(address);
                                }
                                await _refreshKey.currentState
                                    ?.show(atTop: false);
                              },
                              edit: () async {
                                GlobalKey<CustomFormState> formKey =
                                    GlobalKey<CustomFormState>();
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) {
                                    CancelToken token = CancelToken();
                                    return DialogForm(
                                      title: "Edit address",
                                      formKeys: [formKey],
                                      onAccept: () async {
                                        AddressModel? editedAddress =
                                            formKey.currentState?.submit();
                                        if (editedAddress != null) {
                                          UserModel? user = widget.user;
                                          if (user != null) {
                                            await UserApi.updateAddressById(
                                                user.id, editedAddress,
                                                cancelToken: token);
                                          } else {
                                            await UserApi.updateAddress(
                                                editedAddress,
                                                cancelToken: token);
                                          }
                                          if (context.mounted) {
                                            Navigator.of(context).pop();
                                          }
                                          await widget.refreshAddresses();
                                        }
                                      },
                                      onCancel: () async {
                                        GetIt.I<HttpApiClient>()
                                            .cancelRequest(token);
                                      },
                                      children: [
                                        AddressForm(
                                          key: formKey,
                                          address: address,
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              toggleFavorite: () async {
                                address.principal = true;
                                UserModel? user = widget.user;
                                if (user != null) {
                                  await UserApi.updateAddressById(
                                      user.id, address);
                                } else {
                                  await UserService.updateAddress(address);
                                }
                                await _refreshKey.currentState
                                    ?.show(atTop: false);
                              },
                              favorite: address.principal,
                              child: RichText(
                                  text: TextSpan(
                                      text: "Address: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: GetIt.I<ConfigurationStore>()
                                              .theme
                                              .colorScheme
                                              .onBackground,
                                          fontSize: 18),
                                      children: [
                                    TextSpan(
                                        text: address.address,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal)),
                                  ])),
                            );
                          },
                        ),
                      ),
                    ),
                    Visibility(
                        visible:
                            widget.addressesStore.filteredAddresses.isEmpty,
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "No addresses found",
                            style: TextStyle(fontSize: 24),
                          ),
                        ))
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "add-address",
        onPressed: () {
          GlobalKey<CustomFormState> formKey = GlobalKey<CustomFormState>();
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              CancelToken token = CancelToken();
              return DialogForm(
                title: "Add address",
                formKeys: [formKey],
                onAccept: () async {
                  AddressModel? editedAddress = formKey.currentState?.submit();
                  if (editedAddress != null) {
                    UserModel? user = widget.user;
                    if (user != null) {
                      await UserApi.addAddressById(user.id, editedAddress,
                          cancelToken: token);
                    } else {
                      await UserApi.addAddress(editedAddress,
                          cancelToken: token);
                    }
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                    await widget.refreshAddresses();
                  }
                },
                onCancel: () async {
                  GetIt.I<HttpApiClient>().cancelRequest(token);
                },
                children: [AddressForm(key: formKey)],
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
