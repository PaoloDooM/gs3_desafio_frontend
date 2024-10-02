import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gs3_desafio_front/ui/stores/user_store.dart';
import 'package:gs3_desafio_front/ui/widgets/custom_form.dart';
import '../../src/models/telephone_number_model.dart';
import '../stores/configuration_store.dart';

class PhoneForm extends CustomForm {
  final TelephoneNumberModel? phone;

  const PhoneForm({this.phone, super.key});

  @override
  PhoneFormState createState() => PhoneFormState();
}

class PhoneFormState extends CustomFormState<PhoneForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController phoneTextController = TextEditingController();
  final TextEditingController descriptionTextController =
      TextEditingController();
  late bool favorite;
  bool disableForm = false;

  @override
  void initState() {
    favorite = widget.phone?.principal ?? false;
    phoneTextController.text = widget.phone?.number ?? "";
    descriptionTextController.text = widget.phone?.description ?? "";
    super.initState();
  }

  @override
  void dispose() {
    phoneTextController.dispose();
    descriptionTextController.dispose();
    super.dispose();
  }

  @override
  setDisableForm(bool value) {
    setState(() {
      disableForm = value;
    });
  }

  @override
  TelephoneNumberModel? submit() {
    if (_formKey.currentState?.validate() ?? false) {
      return TelephoneNumberModel(
          id: widget.phone?.id ?? -1,
          userId: GetIt.I<UserStore>().user?.id ?? -1,
          description: descriptionTextController.text,
          number: phoneTextController.text,
          principal: favorite);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            enabled: !disableForm,
            validator: (String? text) {
              if ((text ?? "").trim().isEmpty) {
                return "Required field";
              }
              if ((text?.length ?? 0) > 50) {
                return "50 characters maximum";
              }
              return null;
            },
            controller: descriptionTextController,
            decoration: const InputDecoration(
                label: Text("Description"), border: OutlineInputBorder()),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: TextFormField(
              enabled: !disableForm,
              validator: (String? text) {
                if ((text ?? "").trim().isEmpty) {
                  return "Required field";
                }
                if ((text?.length ?? 0) < 5) {
                  return "5 characters minimum";
                }
                return null;
              },
              controller: phoneTextController,
              decoration: const InputDecoration(
                  label: Text("Phone number"), border: OutlineInputBorder()),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  shape: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: GetIt.I<ConfigurationStore>().theme.disabledColor,
                  )),
                ),
                child: CheckboxListTile(
                  value: favorite,
                  enabled: !disableForm,
                  onChanged: (bool? value) async {
                    if (value != null) {
                      setState(() {
                        favorite = value;
                      });
                    }
                  },
                  title: const Text("Favorite"),
                ),
              ))
        ],
      ),
    );
  }
}
