import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../stores/configuration_store.dart';

class PageCard extends StatelessWidget {
  final String label;
  final String description;
  final Future<dynamic> Function() onTap;
  final double height;
  final double width;

  const PageCard(
      {super.key,
      required this.label,
      required this.description,
      required this.onTap,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SizedBox(
        width: width * 0.5,
        height: height * 0.35,
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 7,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: InkWell(
              onTap: () async {
                await onTap();
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            label,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                        ),
                      ),
                      Divider(
                        color: GetIt.I<ConfigurationStore>()
                            .theme
                            .colorScheme
                            .primary,
                        thickness: 2.5,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            description,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      );
    });
  }
}
