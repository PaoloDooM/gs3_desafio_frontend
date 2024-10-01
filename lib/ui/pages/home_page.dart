import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:gs3_desafio_front/src/services/user_service.dart';
import 'package:gs3_desafio_front/ui/stores/user_store.dart';
import '../../main.dart';
import '../stores/configuration_store.dart';
import '../widgets/user_header.dart';
import 'configurations_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  ScrollController drawerScrollbarController = ScrollController();

  @override
  void dispose() {
    drawerScrollbarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Desafio GS3"),
        ),
        body: const SingleChildScrollView(
          child: Wrap(
            children: [],
          ),
        ),
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
