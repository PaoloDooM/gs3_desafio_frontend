import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:gs3_desafio_front/src/services/user_service.dart';
import 'package:gs3_desafio_front/ui/pages/users_page.dart';
import 'package:gs3_desafio_front/ui/stores/user_store.dart';
import 'package:gs3_desafio_front/ui/stores/users_page_store.dart';
import 'package:gs3_desafio_front/ui/widgets/page_card.dart';
import '../../main.dart';
import '../stores/configuration_store.dart';
import '../widgets/info_card.dart';
import '../widgets/user_header.dart';
import 'configurations_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  ScrollController drawerScrollbarController = ScrollController();
  ScrollController homeScrollbarController = ScrollController();

  @override
  void dispose() {
    drawerScrollbarController.dispose();
    homeScrollbarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Desafio GS3"),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          double width = constraints.maxWidth - 16;
          double height = constraints.maxHeight - 16;
          return SizedBox(
            height: double.infinity,
            child: RefreshIndicator(
              onRefresh: () async {
                await UserService.getLoggedUser();
              },
              child: Scrollbar(
                controller: homeScrollbarController,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: homeScrollbarController,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(runSpacing: 2, children: [
                      InfoCard(
                        onTap: () async {},
                        height: height,
                        width: width,
                      ),
                      Visibility(
                        visible:
                            GetIt.I<UserStore>().user?.profile.label == 'admin',
                        child: PageCard(
                          label: "User management",
                          description: "Create, edit, search, and delete users",
                          onTap: () async {
                            UsersPageStore usersPageStore = UsersPageStore();
                            navigatorKey.currentState
                                ?.push(MaterialPageRoute<void>(
                              builder: (BuildContext context) => UsersPage(
                                usersStore: usersPageStore,
                              ),
                            ));
                          },
                          height: height,
                          width: width,
                        ),
                      ),
                      PageCard(
                        label: "Some feature",
                        description: "General-purpose feature",
                        onTap: () async {},
                        height: height,
                        width: width,
                      ),
                      PageCard(
                        label: "Another feature",
                        description: "Additional general-purpose feature",
                        onTap: () async {},
                        height: height,
                        width: width,
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          );
        }),
        drawer: Drawer(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawerHeader(
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: GetIt.I<ConfigurationStore>()
                      .theme
                      .colorScheme
                      .inversePrimary,
                ),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        UserHeader(GetIt.I<UserStore>().user, Axis.vertical)),
              ),
              Expanded(
                child: Scrollbar(
                  controller: drawerScrollbarController,
                  child: SingleChildScrollView(
                    controller: drawerScrollbarController,
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          style: ListTileStyle.drawer,
                          title: const Text("Configurations"),
                          leading: const Icon(Icons.settings),
                          onTap: () {
                            navigatorKey.currentState
                                ?.push(MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const ConfigurationsPage(),
                            ));
                          },
                        ),
                        ListTile(
                          style: ListTileStyle.drawer,
                          title: const Text("logout"),
                          leading: const Icon(Icons.logout),
                          onTap: () async {
                            await UserService.logout();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
