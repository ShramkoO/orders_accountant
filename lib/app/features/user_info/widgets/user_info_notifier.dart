import 'package:cuckoo_starter_kit/core/constants/common_libs.dart';
import 'package:cuckoo_starter_kit/app/features/user_info/cubit/user_info_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfoNotifier extends StatefulWidget {
  const UserInfoNotifier({super.key, required this.child});
  final Widget child;

  @override
  State<UserInfoNotifier> createState() => _UserInfoNotifierState();
}

class _UserInfoNotifierState extends State<UserInfoNotifier> {
  Map<MessageSeverity, Color> snackbarColors = {
    MessageSeverity.error: colors.error,
    MessageSeverity.info: colors.info,
    MessageSeverity.success: colors.success,
    MessageSeverity.warning: colors.warning,
  };

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserInfoCubit, UserInfoState>(
      listener: (context, state) {
        if (state.showSnackbar) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  key: Key('Snackbar'),
                  backgroundColor: snackbarColors[state.severity],
                  duration: const Duration(seconds: 3),
                  content: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      state.message,
                    ),
                  )),
            );
        }
      },
      child: widget.child,
    );
  }
}
