import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gs3_desafio_front/ui/stores/user_store.dart';
import 'package:gs3_desafio_front/ui/widgets/custom_form.dart';
import '../../src/models/profile_model.dart';
import '../../src/models/user_model.dart';
import '../stores/configuration_store.dart';

class UserForm extends CustomForm {
  final UserModel? user;
  final bool adminMode;
  final bool editMode;

  const UserForm(
      {this.user, this.adminMode = false, this.editMode = false, super.key});

  @override
  UserFormState createState() => UserFormState();
}

class UserFormState extends CustomFormState<UserForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController cpfTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController repeatPasswordTextController =
      TextEditingController();
  late List<DropdownMenuItem<ProfileModel>> profiles;
  ProfileModel? selectedProfile;
  bool disableForm = false;
  bool showPassword = false;
  bool editPassword = false;

  @override
  void initState() {
    nameTextController.text = widget.user?.name ?? "";
    cpfTextController.text = widget.user?.cpf ?? "";
    emailTextController.text = widget.user?.email ?? "";
    profiles = GetIt.I<ConfigurationStore>()
        .userProfiles
        .map((element) =>
            DropdownMenuItem(value: element, child: Text(element.label)))
        .toList();
    selectedProfile = profiles
        .firstWhereOrNull((element) =>
            (widget.user?.profile.id ??
                GetIt.I<UserStore>().user?.profile.id) ==
            element.value?.id)
        ?.value;
    super.initState();
  }

  @override
  void dispose() {
    nameTextController.dispose();
    cpfTextController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    repeatPasswordTextController.dispose();
    super.dispose();
  }

  @override
  setDisableForm(bool value) {
    setState(() {
      disableForm = value;
    });
  }

  @override
  UserModel? submit() {
    if (_formKey.currentState?.validate() ?? false) {
      return UserModel(
        id: (widget.adminMode
                ? widget.user?.id
                : GetIt.I<UserStore>().user?.id) ??
            -1,
        name: nameTextController.text,
        email: emailTextController.text,
        cpf: cpfTextController.text,
        password: editPassword || (widget.adminMode && !widget.editMode)
            ? passwordTextController.text
            : null,
        addresses: [],
        telephoneNumbers: [],
        profile: (selectedProfile ?? GetIt.I<UserStore>().user?.profile)!,
      );
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
              if ((text?.length ?? 0) > 150) {
                return "150 characters maximum";
              }
              return null;
            },
            controller: nameTextController,
            decoration: const InputDecoration(
                label: Text("Name"), border: OutlineInputBorder()),
          ),
          Visibility(
            visible: widget.adminMode,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    enabled: !disableForm,
                    validator: (String? text) {
                      if (!widget.adminMode) {
                        return null;
                      }
                      if ((text ?? "").trim().isEmpty) {
                        return "Required field";
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text ?? "")) {
                        return "Invalid email";
                      }
                      return null;
                    },
                    controller: emailTextController,
                    decoration: const InputDecoration(
                        label: Text("Email"), border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    enabled: !disableForm,
                    validator: (String? text) {
                      if (!widget.adminMode) {
                        return null;
                      }
                      if ((text ?? "").trim().isEmpty) {
                        return "Required field";
                      }
                      if (!RegExp(r"^(\d{3}\.?\d{3}\.?\d{3}-?\d{2})$")
                          .hasMatch(text ?? "")) {
                        return "Invalid CPF";
                      }
                      return null;
                    },
                    controller: cpfTextController,
                    decoration: const InputDecoration(
                        label: Text("CPF"), border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Container(
                      width: double.infinity,
                      decoration: ShapeDecoration(
                        shape: OutlineInputBorder(
                            borderSide: BorderSide(
                          color:
                              GetIt.I<ConfigurationStore>().theme.disabledColor,
                        )),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Text(
                                "Profile: ",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: DropdownButton<ProfileModel>(
                                isExpanded: true,
                                items: profiles,
                                value: disableForm ? null : selectedProfile,
                                underline: Container(),
                                onChanged: (ProfileModel? value) {
                                  if (value != null) {
                                    setState(() {
                                      selectedProfile = value;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
          Visibility(
            visible: !(widget.adminMode && !widget.editMode),
            child: Padding(
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
                    value: editPassword,
                    enabled: !disableForm,
                    onChanged: (bool? value) async {
                      if (value != null) {
                        setState(() {
                          editPassword = value;
                        });
                      }
                    },
                    title: const Text("Change password"),
                  ),
                )),
          ),
          Visibility(
            visible: editPassword || (widget.adminMode && !widget.editMode),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    enabled: !disableForm,
                    obscureText: !showPassword,
                    validator: (String? text) {
                      if (!editPassword &&
                          !(widget.adminMode && !widget.editMode)) {
                        return null;
                      }
                      if ((text ?? "").isEmpty) {
                        return "Required field";
                      }
                      if (text != repeatPasswordTextController.text) {
                        return "Password mismatch";
                      }
                      if ((text ?? "").length < 6) {
                        return "6 characters minimum";
                      }
                      return null;
                    },
                    controller: passwordTextController,
                    decoration: InputDecoration(
                      label: const Text("Password"),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          icon: Icon(showPassword
                              ? Icons.remove_red_eye_outlined
                              : Icons.remove_red_eye)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 2),
                  child: TextFormField(
                    enabled: !disableForm,
                    obscureText: !showPassword,
                    validator: (String? text) {
                      if (!editPassword &&
                          !(widget.adminMode && !widget.editMode)) {
                        return null;
                      }
                      if ((text ?? "").isEmpty) {
                        return "Required field";
                      }
                      if (text != passwordTextController.text) {
                        return "Password mismatch";
                      }
                      if ((text ?? "").length < 6) {
                        return "6 characters minimum";
                      }
                      return null;
                    },
                    controller: repeatPasswordTextController,
                    decoration: InputDecoration(
                      label: const Text("Repeat password"),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          icon: Icon(showPassword
                              ? Icons.remove_red_eye_outlined
                              : Icons.remove_red_eye)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
