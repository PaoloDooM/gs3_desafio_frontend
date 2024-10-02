import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:gs3_desafio_front/main.dart';
import 'package:gs3_desafio_front/ui/widgets/detail_card.dart';
import '../../src/apis/http_api_client.dart';
import '../../src/apis/user_api.dart';
import '../../src/configurations.dart';
import '../../src/models/profile_model.dart';
import '../../src/models/user_model.dart';
import '../../src/services/user_service.dart';
import '../stores/configuration_store.dart';
import '../stores/users_page_store.dart';
import '../widgets/custom_form.dart';
import '../widgets/dialog_form.dart';
import '../widgets/error_message.dart';
import '../widgets/user_details.dart';
import '../widgets/user_form.dart';

class UsersPage extends StatefulWidget {
  final UsersPageStore usersStore;

  const UsersPage({super.key, required this.usersStore});

  @override
  State<StatefulWidget> createState() => UsersPageState();
}

class UsersPageState extends State<UsersPage> {
  ScrollController scrollBarBodyController = ScrollController();
  ScrollController scrollBarDrawerController = ScrollController();
  TextEditingController searchController = TextEditingController();
  final GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<DropdownMenuItem<ProfileModel>> profiles = [
    ProfileModel(id: -1, label: 'All profiles'),
    ...GetIt.I<ConfigurationStore>().userProfiles
  ]
      .map((element) =>
          DropdownMenuItem(value: element, child: Text(element.label)))
      .toList();

  @override
  void initState() {
    widget.usersStore.setProfile(profiles.first.value);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      refreshKey.currentState?.show(atTop: true);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    scrollBarDrawerController.dispose();
    scrollBarBodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: const Text("Users"),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  navigatorKey.currentState?.pop();
                }),
            actions: [
              IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    _scaffoldKey.currentState?.openEndDrawer();
                  }),
            ],
          ),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: searchController,
                  onChanged: (String? value) {
                    widget.usersStore.setSearchString(value ?? "");
                  },
                  decoration: InputDecoration(
                      label: const Text("Search"),
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                          onPressed: () {
                            widget.usersStore.setSearchString("");
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
                      key: refreshKey,
                      onRefresh: () async {
                        await widget.usersStore.refreshUsers();
                      },
                      child: Scrollbar(
                        controller: scrollBarBodyController,
                        child: widget.usersStore.loadingStatus ==
                                LoadingStatus.error
                            ? ErrorMessage(
                                onRetry: () async {
                                  refreshKey.currentState?.show();
                                },
                                theme: GetIt.I<ConfigurationStore>().theme)
                            : ListView.builder(
                                padding: const EdgeInsets.only(bottom: 60),
                                controller: scrollBarBodyController,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount:
                                    widget.usersStore.filteredUsers.length,
                                itemBuilder: (context, index) {
                                  UserModel user =
                                      widget.usersStore.filteredUsers[index];
                                  return DetailCard(
                                    delete: () async {
                                      await UserService.deleteUser(user);
                                      await refreshKey.currentState
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
                                            title: "Edit user",
                                            formKeys: [formKey],
                                            onAccept: () async {
                                              UserModel? editedUser = formKey
                                                  .currentState
                                                  ?.submit();
                                              if (editedUser != null) {
                                                await UserApi.updateUserById(
                                                    editedUser,
                                                    cancelToken: token);
                                                if (context.mounted) {
                                                  Navigator.of(context).pop();
                                                }
                                                await refreshKey.currentState
                                                    ?.show();
                                              }
                                            },
                                            onCancel: () async {
                                              GetIt.I<HttpApiClient>()
                                                  .cancelRequest(token);
                                            },
                                            children: [
                                              UserForm(
                                                key: formKey,
                                                user: user,
                                                adminMode: true,
                                                editMode: true,
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: UserDetails(
                                      usersStrore: widget.usersStore,
                                      refreshKey: refreshKey,
                                      user: user,
                                      theme:
                                          GetIt.I<ConfigurationStore>().theme,
                                      listTile: true,
                                    ),
                                  );
                                }),
                      ),
                    ),
                    Visibility(
                        visible: widget.usersStore.filteredUsers.isEmpty &&
                            widget.usersStore.loadingStatus ==
                                LoadingStatus.loaded,
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "No users found",
                            style: TextStyle(fontSize: 24),
                          ),
                        ))
                  ],
                ),
              ),
            ],
          ),
          endDrawer: Drawer(
            child: Scrollbar(
              controller: scrollBarDrawerController,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 32.0, left: 12, right: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Filters",
                            style: TextStyle(fontSize: 32),
                          )),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Container(
                          width: double.infinity,
                          decoration: ShapeDecoration(
                            shape: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: GetIt.I<ConfigurationStore>()
                                  .theme
                                  .disabledColor,
                            )),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    "Profile: ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: DropdownButton<ProfileModel>(
                                    isExpanded: true,
                                    items: profiles,
                                    value: widget.usersStore.profile,
                                    underline: Container(),
                                    onChanged: (ProfileModel? value) {
                                      if (value != null) {
                                        widget.usersStore.setProfile(value);
                                        navigatorKey.currentState?.pop();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: "add-user",
            onPressed: () {
              GlobalKey<CustomFormState> formKey = GlobalKey<CustomFormState>();
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  CancelToken token = CancelToken();
                  return DialogForm(
                    title: "Add user",
                    formKeys: [formKey],
                    onAccept: () async {
                      UserModel? editedUser = formKey.currentState?.submit();
                      if (editedUser != null) {
                        await UserApi.addUser(editedUser, cancelToken: token);
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                        await refreshKey.currentState?.show();
                      }
                    },
                    onCancel: () async {
                      GetIt.I<HttpApiClient>().cancelRequest(token);
                    },
                    children: [
                      UserForm(
                        key: formKey,
                        adminMode: true,
                      )
                    ],
                  );
                },
              );
            },
            child: const Icon(
              Icons.add,
            ),
          ),
        );
      },
    );
  }
}
