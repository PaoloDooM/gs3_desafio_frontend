import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:gs3_desafio_front/ui/stores/user_store.dart';

import '../stores/configuration_store.dart';

class InfoCard extends StatelessWidget {
  final Future<dynamic> Function() onTap;
  final double height;
  final double width;

  const InfoCard(
      {super.key,
      required this.onTap,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SizedBox(
          width: width,
          height: height * 0.30,
          child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 7,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: InkWell(
                  onTap: () async {
                    await onTap();
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome ${GetIt.I<UserStore>().user?.name.split(" ").first ?? "User"}!",
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: RichText(
                                  text: TextSpan(
                                      text: "Pending notifications ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: GetIt.I<ConfigurationStore>()
                                              .theme
                                              .colorScheme
                                              .onBackground),
                                      children: [
                                        WidgetSpan(
                                            child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.5, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: GetIt.I<ConfigurationStore>()
                                                .theme
                                                .colorScheme
                                                .primary,
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          child: Text(
                                            '0',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.0,
                                              color:
                                                  GetIt.I<ConfigurationStore>()
                                                      .theme
                                                      .colorScheme
                                                      .onPrimary,
                                            ),
                                          ),
                                        )),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: height,
                          width: width * 0.35,
                          decoration: BoxDecoration(
                            color: GetIt.I<ConfigurationStore>()
                                .theme
                                .colorScheme
                                .inverseSurface,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              topRight: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              fit: BoxFit.scaleDown,
                              GetIt.I<ConfigurationStore>().darkMode
                                  ? "assets/light-logo.png"
                                  : "assets/dark-logo.png",
                            ),
                          ),
                        ),
                      ]))));
    });
  }
}
