import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:gs3_desafio_front/ui/widgets/user_header.dart';
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
        body: Scrollbar(
          controller: scrollBarBodyController,
          child: SingleChildScrollView(
            controller: scrollBarBodyController,
            child: Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        UserHeader(GetIt.I<UserStore>().user, Axis.horizontal),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit,
                                color: GetIt.I<ConfigurationStore>()
                                    .theme
                                    .colorScheme
                                    .tertiary,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("User information")),
                      Divider(
                          color: GetIt.I<ConfigurationStore>()
                              .theme
                              .colorScheme
                              .secondary),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, top: 16, right: 8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                              text: TextSpan(
                                  text: "Email: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: GetIt.I<ConfigurationStore>()
                                          .theme
                                          .colorScheme
                                          .onBackground),
                                  children: [
                                TextSpan(
                                    text:
                                        "${GetIt.I<UserStore>().user?.email ?? " "}\n",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal)),
                              ])),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, top: 0, right: 8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                                text: "CPF: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: GetIt.I<ConfigurationStore>()
                                        .theme
                                        .colorScheme
                                        .onBackground),
                                children: [
                                  TextSpan(
                                      text:
                                          GetIt.I<UserStore>().user?.cpf ?? " ",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal))
                                ]),
                          ),
                        ),
                      ),
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
