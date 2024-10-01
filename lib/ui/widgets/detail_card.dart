import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../stores/configuration_store.dart';

class DetailCard extends StatelessWidget {
  final bool favorite;
  final String title;
  final Widget child;
  final Future<void> Function() delete;
  final Future<void> Function() edit;
  final Future<void> Function() toggleFavorite;

  const DetailCard(
      {super.key,
      required this.child,
      required this.delete,
      required this.edit,
      required this.toggleFavorite,
      required this.favorite,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22),
                ),
                IconButton(
                    onPressed: () async {
                      await toggleFavorite();
                    },
                    icon: Icon(
                      favorite ? Icons.star : Icons.star_border,
                      color: GetIt.I<ConfigurationStore>()
                          .theme
                          .colorScheme
                          .primary,
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: child,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () async {
                      await delete();
                    },
                    icon: Icon(
                      Icons.delete,
                      color: GetIt.I<ConfigurationStore>()
                          .theme
                          .colorScheme
                          .tertiary,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.edit,
                      color: GetIt.I<ConfigurationStore>()
                          .theme
                          .colorScheme
                          .tertiary,
                    ))
              ],
            )
          ],
        ),
      )),
    );
  }
}
