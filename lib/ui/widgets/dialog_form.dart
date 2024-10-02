import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gs3_desafio_front/main.dart';
import 'package:gs3_desafio_front/ui/widgets/custom_form.dart';
import 'package:gs3_desafio_front/ui/widgets/error_message.dart';
import '../stores/configuration_store.dart';

class DialogForm extends StatefulWidget {
  final String title;
  final List<Widget> children;
  final List<GlobalKey<CustomFormState>> formKeys;
  final Future<void> Function() onAccept;
  final Future<void> Function() onCancel;

  const DialogForm({
    super.key,
    required this.title,
    required this.children,
    required this.formKeys,
    required this.onAccept,
    required this.onCancel,
  });

  @override
  State<DialogForm> createState() => _DialogFormState();
}

class _DialogFormState extends State<DialogForm> {
  final ScrollController scrollbarController = ScrollController();
  String? errorMessage;
  bool disabledForm = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 16, bottom: 20),
                child: Text(
                  widget.title,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            Flexible(
              child: Scrollbar(
                  controller: scrollbarController,
                  child: SingleChildScrollView(
                      controller: scrollbarController,
                      child: Stack(
                        children: [
                          Visibility(
                            visible: errorMessage == null,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8),
                              child: Column(
                                children: widget.children,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: errorMessage != null,
                            child: Container(
                              color: GetIt.I<ConfigurationStore>()
                                  .theme
                                  .colorScheme
                                  .background,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: ErrorMessage(
                                  errorMessage: errorMessage,
                                  theme: GetIt.I<ConfigurationStore>().theme,
                                  onRetry: () async {
                                    setState(() {
                                      errorMessage = null;
                                      disabledForm = false;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ))),
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
                      await widget.onCancel();
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
                    onPressed: disabledForm
                        ? null
                        : () async {
                            try {
                              for (GlobalKey<CustomFormState> formKey
                                  in widget.formKeys) {
                                formKey.currentState?.setDisableForm(true);
                                setState(() {
                                  disabledForm = true;
                                });
                              }
                              await widget.onAccept();
                            } catch (e) {
                              if (context.mounted) {
                                setState(() {
                                  errorMessage = "$e";
                                });
                              }
                            } finally {
                              for (GlobalKey<CustomFormState> formKey
                                  in widget.formKeys) {
                                formKey.currentState?.setDisableForm(false);
                                if (context.mounted) {
                                  setState(() {
                                    disabledForm =
                                        errorMessage != null || false;
                                  });
                                }
                              }
                            }
                          },
                    child: const Text('Save', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
