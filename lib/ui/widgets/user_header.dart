import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../src/models/user_model.dart';
import '../stores/configuration_store.dart';

class UserHeader extends StatelessWidget {
  final UserModel? user;
  final Axis axis;

  const UserHeader(this.user, this.axis, {super.key});

  @override
  Widget build(BuildContext context) {
    if (axis == Axis.vertical) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: buildChildren(),
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: buildChildren(),
    );
  }

  List<Widget> buildChildren() {
    return [
      axis == Axis.vertical
          ? const Spacer()
          : const SizedBox(
              width: 12,
            ),
      Center(
        child: CircleAvatar(
          minRadius: 20,
          maxRadius: 35,
          backgroundColor:
              GetIt.I<ConfigurationStore>().theme.colorScheme.primary,
          child: Text(
            getInitialsFromName(user?.name ?? ""),
            style: TextStyle(
                color:
                    GetIt.I<ConfigurationStore>().theme.colorScheme.onPrimary,
                fontSize: 28,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      axis == Axis.vertical
          ? const Spacer()
          : const SizedBox(
              width: 12,
            ),
      Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stringToTitle(user?.profile.label ?? ""),
              style: TextStyle(
                  color: GetIt.I<ConfigurationStore>()
                      .theme
                      .colorScheme
                      .onBackground),
            ),
            Text(
              user?.name ?? "",
              style: TextStyle(
                  color: GetIt.I<ConfigurationStore>()
                      .theme
                      .colorScheme
                      .onBackground,
                  fontSize: 20),
            )
          ])
    ];
  }

  String getInitialsFromName(String name) {
    List<String> names = name.trim().split(" ");
    if (names.length < 2) {
      if (names.first.length < 2) {
        return names.first;
      }
      return names.first.substring(0, 2);
    }
    return (names[0][0] + names[1][0]).toUpperCase();
  }

  String stringToTitle(String string) {
    if (string.isNotEmpty) {
      return string[0].toUpperCase() + string.substring(1);
    }
    return string;
  }
}
