import 'package:cuckoo_starter_kit/core/constants/common_libs.dart';
import 'package:cuckoo_starter_kit/app/widgets/controls/buttons.dart';
import 'package:cuckoo_starter_kit/app/widgets/controls/checkbox.dart';
import 'package:gap/gap.dart';

class NewPasswordScreen extends StatefulWidget {
  static const routeName = '/password-reset';
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordRepeatController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> updatePassword() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    await authCubit.updatePassword(
      newPassword: _passwordController.text,
    );
  }

  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
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
                    controller: _passwordController,
                    hintText: 'Password',
                    obscureText: !showPassword,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Required';
                      }
                      if (val.length < 6) {
                        return '6 characters minimum';
                      }
                      return null;
                    },
                    inputType: TextInputType.emailAddress,
                  ),
              Gap(styles.insets.sm),
              widgets.createTextField().render(
                    controller: _passwordRepeatController,
                    hintText: 'Repeat password',
                    obscureText: !showPassword,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Required';
                      }
                      if (val != _passwordController.text) {
                        return 'Passwords are not the same';
                      }
                      return null;
                    },
                    inputType: TextInputType.emailAddress,
                  ),
              SimpleCheckbox(
                active: showPassword,
                onToggled: (bool? val) =>
                    setState(() => showPassword = val ?? false),
                label: 'Show passwords',
              ),
              Gap(styles.insets.sm),
              AppButton.from(
                text: 'Reset password',
                expand: true,
                onPressed: () => updatePassword(),
              ),
            ],
          ),
        ),
      ),
      // ),
      // ),
    );
  }
}
