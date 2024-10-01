import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gs3_desafio_front/main.dart';
import 'package:gs3_desafio_front/src/services/user_service.dart';
import 'package:gs3_desafio_front/ui/pages/home_page.dart';
import '../stores/configuration_store.dart';
import '../stores/user_store.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberEmail = false;
  bool showPassword = false;
  bool loaded = false;
  bool disableForm = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<bool> loadFromStorage() async {
    if (!loaded) {
      await GetIt.I<ConfigurationStore>().loadDarkModeFromStorage();
      String? apiToken = await GetIt.I<UserStore>().loadApiTokenFromStorage();
      if (apiToken != null) {
        await getUserAndNavigateToHome();
      } else {
        String? rememberedEmail = await UserService.getRememberedEmail();
        rememberEmail = rememberedEmail != null;
        emailController.text = rememberedEmail ?? "";
      }
      loaded = true;
    }
    return loaded;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: 20,
                  ),
                  child: Card(
                    elevation: 10,
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      constraints: const BoxConstraints(
                          minHeight: 250,
                          minWidth: 320,
                          maxHeight: 800,
                          maxWidth: 600),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text("Desafio GS3",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24)),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12.0),
                                      child: TextFormField(
                                        controller: emailController,
                                        enabled: !disableForm,
                                        validator: (String? value) {
                                          if ((value ?? "").isEmpty) {
                                            return "Required field";
                                          } else if (!RegExp(
                                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(value ?? "")) {
                                            return "Invalid email";
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            label: Text("Email"),
                                            prefixIcon: Icon(Icons.person),
                                            border: OutlineInputBorder()),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: passwordController,
                                      enabled: !disableForm,
                                      validator: (String? value) {
                                        if ((value ?? "").isEmpty) {
                                          return "Required field";
                                        }
                                        return null;
                                      },
                                      obscureText: !showPassword,
                                      decoration: InputDecoration(
                                          label: const Text("Password"),
                                          prefixIcon: const Icon(Icons.key),
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  showPassword = !showPassword;
                                                });
                                              },
                                              icon: Icon(showPassword
                                                  ? Icons
                                                      .remove_red_eye_outlined
                                                  : Icons.remove_red_eye)),
                                          border: const OutlineInputBorder()),
                                    ),
                                    CheckboxListTile(
                                      value: rememberEmail,
                                      enabled: !disableForm,
                                      onChanged: (bool? value) async {
                                        if (value != null) {
                                          if (!value) {
                                            await UserService
                                                .deleteRememberedEmail();
                                          }
                                          setState(() {
                                            rememberEmail = value;
                                          });
                                        }
                                      },
                                      title: const Text("Remember email"),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                            onPressed: disableForm
                                                ? null
                                                : () async {
                                                    if (_formKey.currentState
                                                            ?.validate() ??
                                                        false) {
                                                      setState(() {
                                                        showPassword = false;
                                                        disableForm = true;
                                                      });
                                                      await UserService.login(
                                                          emailController.text,
                                                          passwordController
                                                              .text,
                                                          rememberEmail);
                                                      try {
                                                        await getUserAndNavigateToHome();
                                                      } catch (e) {
                                                        snackbarKey.currentState
                                                          ?..clearSnackBars()
                                                          ..showSnackBar(
                                                              SnackBar(
                                                                  content: Text(
                                                                    "$e",
                                                                    style: TextStyle(
                                                                        color: GetIt.I<ConfigurationStore>()
                                                                            .theme
                                                                            .colorScheme
                                                                            .onError),
                                                                  ),
                                                                  duration:
                                                                      const Duration(
                                                                          seconds:
                                                                              12),
                                                                  backgroundColor: GetIt.I<
                                                                          ConfigurationStore>()
                                                                      .theme
                                                                      .colorScheme
                                                                      .error));
                                                        setState(() {
                                                          disableForm = false;
                                                        });
                                                      }
                                                    }
                                                  },
                                            child: disableForm
                                                ? SizedBox.fromSize(
                                                    size: const Size(20, 20),
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: GetIt.I<
                                                              ConfigurationStore>()
                                                          .theme
                                                          .colorScheme
                                                          .secondary,
                                                    ))
                                                : const Text(
                                                    "Login",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0, right: 16),
                    child: FloatingActionButton(
                      heroTag: "darkMode-tag",
                      onPressed: () async {
                        await GetIt.I<ConfigurationStore>().toggleDarkMode();
                        setState(() {});
                      },
                      child: Icon(!GetIt.I<ConfigurationStore>().darkMode
                          ? Icons.nightlight
                          : Icons.sunny),
                    ),
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color:
                        GetIt.I<ConfigurationStore>().theme.colorScheme.error,
                    size: 128,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Something went wrong",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  TextButton(
                      onPressed: () async {
                        await GetIt.I<UserStore>().setApiToken(null);
                        await GetIt.I<UserStore>().setUser(null);
                        setState(() {});
                      },
                      child: const Text("Retry",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)))
                ],
              ),
            );
          } else {
            return Center(
                child: AnimatedBuilder(
              animation: _animation,
              builder: (BuildContext context, Widget? child) {
                return Transform.scale(
                    scale: 1 + _animation.value / 10, child: child);
              },
              child: Image.asset(
                GetIt.I<ConfigurationStore>().darkMode
                    ? 'assets/dark-logo.png'
                    : 'assets/light-logo.png',
              ),
            ));
          }
        },
        future: loadFromStorage(),
      ),
    );
  }

  Future<void> getUserAndNavigateToHome() async {
    await UserService.getLoggedUser();
    navigatorKey.currentState?.pushReplacement(MaterialPageRoute<void>(
      builder: (BuildContext context) => const HomePage(),
    ));
  }
}
