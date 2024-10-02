import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:gs3_desafio_front/main.dart';
import 'package:gs3_desafio_front/ui/widgets/detail_card.dart';
import '../../src/apis/http_api_client.dart';
import '../../src/apis/user_api.dart';
import '../../src/models/telephone_number_model.dart';
import '../../src/models/user_model.dart';
import '../../src/services/user_service.dart';
import '../stores/configuration_store.dart';
import '../stores/phone_page_store.dart';
import '../widgets/custom_form.dart';
import '../widgets/dialog_form.dart';
import '../widgets/phone_form.dart';

class PhonesPage extends StatefulWidget {
  final UserModel? user;
  final PhonePageStore phonesStore;
  final Future<void> Function() refreshPhones;

  const PhonesPage(
      {super.key,
      required this.phonesStore,
      required this.refreshPhones,
      this.user});

  @override
  State<StatefulWidget> createState() => PhonesPageState();
}

class PhonesPageState extends State<PhonesPage> {
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
        title: const Text("Phone numbers"),
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
                    widget.phonesStore.setSearchString(value ?? "");
                  },
                  decoration: InputDecoration(
                      label: const Text("Search"),
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                          onPressed: () {
                            widget.phonesStore.setSearchString("");
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
                        await widget.refreshPhones();
                      },
                      child: Scrollbar(
                        controller: scrollBarController,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 60),
                          controller: scrollBarController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount:
                              widget.phonesStore.filteredPhoneNumbers.length,
                          itemBuilder: (context, index) {
                            TelephoneNumberModel phone =
                                widget.phonesStore.filteredPhoneNumbers[index];
                            return DetailCard(
                              title: phone.description,
                              delete: () async {
                                UserModel? user = widget.user;
                                if (user != null) {
                                  await UserApi.deletePhoneById(user.id, phone);
                                } else {
                                  await UserService.deletePhone(phone);
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
                                      title: "Edit phone number",
                                      formKeys: [formKey],
                                      onAccept: () async {
                                        TelephoneNumberModel? editedPhone =
                                            formKey.currentState?.submit();
                                        if (editedPhone != null) {
                                          UserModel? user = widget.user;
                                          if (user != null) {
                                            await UserApi.updatePhoneById(
                                                user.id, editedPhone,
                                                cancelToken: token);
                                          } else {
                                            await UserApi.updatePhone(
                                                editedPhone,
                                                cancelToken: token);
                                          }
                                          if (context.mounted) {
                                            Navigator.of(context).pop();
                                          }
                                          await widget.refreshPhones();
                                        }
                                      },
                                      onCancel: () async {
                                        GetIt.I<HttpApiClient>()
                                            .cancelRequest(token);
                                      },
                                      children: [
                                        PhoneForm(
                                          key: formKey,
                                          phone: phone,
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              toggleFavorite: () async {
                                phone.principal = true;
                                UserModel? user = widget.user;
                                if (user != null) {
                                  await UserApi.updatePhoneById(user.id, phone);
                                } else {
                                  await UserService.updatePhone(phone);
                                }
                                await _refreshKey.currentState
                                    ?.show(atTop: false);
                              },
                              favorite: phone.principal,
                              child: RichText(
                                  text: TextSpan(
                                      text: "Phone: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: GetIt.I<ConfigurationStore>()
                                              .theme
                                              .colorScheme
                                              .onBackground,
                                          fontSize: 18),
                                      children: [
                                    TextSpan(
                                        text: phone.number,
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
                            widget.phonesStore.filteredPhoneNumbers.isEmpty,
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "No phones found",
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
        heroTag: "add-phone",
        onPressed: () {
          GlobalKey<CustomFormState> formKey = GlobalKey<CustomFormState>();
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              CancelToken token = CancelToken();
              return DialogForm(
                title: "Add phone number",
                formKeys: [formKey],
                onAccept: () async {
                  TelephoneNumberModel? editedPhone =
                      formKey.currentState?.submit();
                  if (editedPhone != null) {
                    UserModel? user = widget.user;
                    if (user != null) {
                      await UserApi.addPhoneById(user.id, editedPhone,
                          cancelToken: token);
                    } else {
                      await UserApi.addPhone(editedPhone, cancelToken: token);
                    }
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                    await widget.refreshPhones();
                  }
                },
                onCancel: () async {
                  GetIt.I<HttpApiClient>().cancelRequest(token);
                },
                children: [PhoneForm(key: formKey)],
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
