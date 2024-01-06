import 'package:orders_accountant/core/constants/common_libs.dart';
import 'package:orders_accountant/app/widgets/controls/buttons.dart';
import 'package:gap/gap.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/forgot-password';
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  Future<void> resetPassword() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    setState(() => isLoading = true);

    await authCubit.resetPassword(
      email: _emailController.text,
    );
    setState(() => isLoading = false);

    appRouter.pop();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }
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
                    hintText: 'Email',
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                    inputType: TextInputType.emailAddress,
                  ),
              Gap(styles.insets.sm),
              AppButton.from(
                text: 'Reset password',
                expand: true,
                onPressed: resetPassword,
              ),
            ],
          ),
        ),
      ),
      //   ),
      // ),
    );
  }
}
