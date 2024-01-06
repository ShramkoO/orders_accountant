import 'package:orders_accountant/app/features/auth/cubit/auth_cubit.dart';
import 'package:orders_accountant/app/widgets/controls/buttons.dart';
import 'package:orders_accountant/app/widgets/controls/checkbox.dart';
import 'package:orders_accountant/core/constants/common_libs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static String routeName = '/sign_in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool showPassword = false;

  final _formKey = GlobalKey<FormState>();

  Future<void> signIn() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    await authCubit.signIn(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) async {
        if (state is Authenticated) {
          appRouter.go(ScreenPaths.home);
        }
      },
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
                    widgets.createTextField().render(
                          controller: _emailController,
                          hintText: 'your@email.com',
                          // icon: Icons.alternate_email,
                          label: 'Deine E-Mail',
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Required';
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
                              return 'Required';
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
                    AppButton.text(
                      onPressed: () {
                        appRouter.push(ScreenPaths.forgotPassword);
                      },
                      text: 'Passwort vergessen?',
                    ),
                    Gap(styles.insets.sm),
                    AppButton.filled(onPressed: signIn, text: 'Anmelden'),
                    Gap(styles.insets.lg),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Noch keinen Account?'),
                        AppButton.text(
                          onPressed: () => appRouter.go(ScreenPaths.signUp),
                          text: 'Erstelle dir einen',
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
