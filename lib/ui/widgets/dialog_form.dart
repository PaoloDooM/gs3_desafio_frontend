import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gs3_desafio_front/main.dart';
import 'package:gs3_desafio_front/ui/widgets/custom_form.dart';
import '../stores/configuration_store.dart';

class DialogForm extends StatelessWidget {
  final String title;
  final List<CustomForm> forms;
  final List<GlobalKey<CustomFormState>> formKeys;
  final Future<void> Function() onAccept;
  final Future<void> Function() onCancel;
  final ScrollController scrollbarController = ScrollController();

  DialogForm({
    super.key,
    required this.title,
    required this.forms,
    required this.formKeys,
    required this.onAccept,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
        child: Scrollbar(
            controller: scrollbarController,
            child: SingleChildScrollView(
                controller: scrollbarController,
                child: Column(children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 16, bottom: 20),
                      child: Text(
                        title,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Column(
                      children: forms,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () async {
                            await onCancel();
                            navigatorKey.currentState?.pop();
                          },
                          child: Text(
                            'Discard',
                            style: TextStyle(
                                color: GetIt.I<ConfigurationStore>()
                                    .theme
                                    .colorScheme
                                    .secondary,
                                fontSize: 18),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            for (GlobalKey<CustomFormState> formKey
                                in formKeys) {
                              formKey.currentState?.setDisableForm(true);
                            }
                            await onAccept();
                            for (GlobalKey<CustomFormState> formKey
                                in formKeys) {
                              formKey.currentState?.setDisableForm(false);
                            }
                          },
                          child: const Text('Save',
                              style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                  )
                ]))));
  }
}
