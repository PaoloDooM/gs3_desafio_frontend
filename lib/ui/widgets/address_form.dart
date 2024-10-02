import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gs3_desafio_front/ui/stores/user_store.dart';
import 'package:gs3_desafio_front/ui/widgets/custom_form.dart';
import '../../src/models/address_model.dart';
import '../stores/configuration_store.dart';

class AddressForm extends CustomForm {
  final AddressModel? address;

  const AddressForm({this.address, super.key});

  @override
  AddressFormState createState() => AddressFormState();
}

class AddressFormState extends CustomFormState<AddressForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController addressTextController = TextEditingController();
  final TextEditingController descriptionTextController =
      TextEditingController();
  late bool favorite;
  bool disableForm = false;

  @override
  void initState() {
    favorite = widget.address?.principal ?? false;
    addressTextController.text = widget.address?.address ?? "";
    descriptionTextController.text = widget.address?.description ?? "";
    super.initState();
  }

  @override
  void dispose() {
    addressTextController.dispose();
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
  AddressModel? submit() {
    if (_formKey.currentState?.validate() ?? false) {
      return AddressModel(
          id: widget.address?.id ?? -1,
          userId: GetIt.I<UserStore>().user?.id ?? -1,
          description: descriptionTextController.text,
          address: addressTextController.text,
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
              if ((text?.length ?? 0) < 5) {
                return "5 characters minimum";
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
              maxLines: 3,
              minLines: 3,
              validator: (String? text) {
                if ((text ?? "").trim().isEmpty) {
                  return "Required field";
                }
                if ((text?.length ?? 0) < 10) {
                  return "10 characters minimum";
                }
                if ((text?.length ?? 0) > 255) {
                  return "255 characters maximum";
                }
                return null;
              },
              controller: addressTextController,
              decoration: const InputDecoration(
                  label: Text("Address"), border: OutlineInputBorder()),
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
