import 'package:cuckoo_starter_kit/app/features/auth/cubit/auth_cubit.dart';
import 'package:cuckoo_starter_kit/app/features/user_info/cubit/user_info_cubit.dart';
import 'package:cuckoo_starter_kit/app/widgets/controls/buttons.dart';
import 'package:cuckoo_starter_kit/app/widgets/controls/checkbox.dart';
import 'package:cuckoo_starter_kit/core/constants/common_libs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static String routeName = '/sign_up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordRepeatController =
      TextEditingController();

  bool showPassword = false;

  final _formKey = GlobalKey<FormState>();

  Future<void> signUp() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    try {
      await authCubit.signUp(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      userInfoCubit.showSnackbar(
          message:
              'Please confirm your email by clicking on the link we sent you',
          severity: MessageSeverity.success);
    } catch (e) {
      userInfoCubit.showSnackbar(
          message: e.toString(), severity: MessageSeverity.error);
    }
  }

  int taps = 0;
  int tapsToReset = 8;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading || state is Authenticated) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else {
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(styles.insets.body),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: widgets.createTextField().render(
                                controller: _firstNameController,
                                inputType: TextInputType.text,
                                hintText: 'Vorname',
                                label: 'Dein Vorname',
                                // icon: Icons.person,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Erforderlich';
                                  }
                                  return null;
                                },
                              ),
                        ),
                        Gap(styles.insets.sm),
                        Expanded(
                          child: widgets.createTextField().render(
                                controller: _lastNameController,
                                inputType: TextInputType.text,
                                hintText: 'Nachname',
                                label: 'Dein Nachname',
                                // icon: Icons.person,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Erforderlich';
                                  }
                                  return null;
                                },
                              ),
                        ),
                      ],
                    ),
                    widgets.createTextField().render(
                          controller: _emailController,
                          hintText: 'your@email.com.',
                          // icon: Icons.alternate_email,
                          label: 'Deine E-Mail',
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Erforderlich';
                            }
                            return null;
                          },
                          inputType: TextInputType.emailAddress,
                        ),
                    widgets.createTextField().render(
                          controller: _passwordController,
                          hintText: '************',
                          label: 'Passwort',
                          // icon: Icons.password,
                          obscureText: !showPassword,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Erforderlich';
                            }
                            if (val.length < 6) {
                              return 'Mindestens 6 Zeichen';
                            }
                            return null;
                          },
                          inputType: TextInputType.visiblePassword,
                        ),
                    widgets.createTextField().render(
                          controller: _passwordRepeatController,
                          hintText: '************',
                          label: 'Passwort wiederholen',
                          // icon: Icons.password,
                          obscureText: !showPassword,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Erforderlich';
                            }
                            if (val.trim() != _passwordController.text.trim()) {
                              return 'Passwörter stimmen nicht überein';
                            }
                            return null;
                          },
                          inputType: TextInputType.visiblePassword,
                        ),
                    SimpleCheckbox(
                      active: showPassword,
                      onToggled: (bool? val) =>
                          setState(() => showPassword = val ?? false),
                      label: 'Passwort anzeigen',
                    ),
                    AppButton.filled(
                        key: Key('Sign Up'),
                        onPressed: signUp,
                        text: 'Registrieren'),
                    Gap(styles.insets.lg),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Schon einen Account?'),
                        AppButton.text(
                          onPressed: () => appRouter.go(ScreenPaths.signIn),
                          text: 'Melde dich an',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
