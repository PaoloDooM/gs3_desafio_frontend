import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:gs3_desafio_front/ui/widgets/user_details.dart';
import '../../main.dart';
import '../stores/configuration_store.dart';
import '../stores/user_store.dart';

class ConfigurationsPage extends StatefulWidget {
  const ConfigurationsPage({super.key});

  @override
  State<StatefulWidget> createState() => ConfigurationsPageState();
}

class ConfigurationsPageState extends State<ConfigurationsPage> {
  ScrollController scrollBarBodyController = ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void dispose() {
    scrollBarBodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Configurations"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              navigatorKey.currentState?.pop();
            },
          ),
        ),
        body: RefreshIndicator(
          key: _refreshKey,
          onRefresh: () async {
            await GetIt.I<UserStore>().refreshUser();
          },
          child: Scrollbar(
            controller: scrollBarBodyController,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: scrollBarBodyController,
              children: [
                UserDetails(
                    user: GetIt.I<UserStore>().user,
                    theme: GetIt.I<ConfigurationStore>().theme,
                    refreshKey: _refreshKey),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 32.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("App configuration")),
                      ),
                      Divider(
                          color: GetIt.I<ConfigurationStore>()
                              .theme
                              .colorScheme
                              .secondary),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, top: 16, right: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Dark mode",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: GetIt.I<ConfigurationStore>()
                                        .theme
                                        .colorScheme
                                        .onBackground)),
                            Switch(
                              onChanged: (value) =>
                                  GetIt.I<ConfigurationStore>()
                                      .toggleDarkMode(),
                              value: GetIt.I<ConfigurationStore>().darkMode,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
