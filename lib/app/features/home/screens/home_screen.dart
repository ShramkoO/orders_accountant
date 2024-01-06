import 'package:cuckoo_starter_kit/app/features/home/cubit/home_cubit.dart';
import 'package:cuckoo_starter_kit/core/constants/common_libs.dart';
import 'package:cuckoo_starter_kit/app/features/user_info/cubit/user_info_cubit.dart';
import 'package:cuckoo_starter_kit/app/widgets/app_modals.dart';
import 'package:cuckoo_starter_kit/app/widgets/controls/buttons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  // Every Screen should have a routeName, for safe access in the router
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(styles.insets.body),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton.filled(
                    onPressed: () {
                      userInfoCubit.showSnackbar(
                        message: 'This is a snackbar',
                        severity: MessageSeverity.info,
                      );
                    },
                    text: 'show snackbar',
                  ),
                  Gap(styles.insets.sm),
                  AppButton.from(
                    onPressed: () async {
                      await widgets.createPopup().show(
                            context: context,
                            title: 'Popup',
                            msg: 'This is a popup',
                          );
                    },
                    text: 'show popup',
                  ),
                  Gap(styles.insets.sm),
                  AppButton.from(
                    onPressed: () async {
                      await showModal(
                        context,
                        child: const OkCancelModal(
                          title: 'Modal',
                          msg: 'This is a modal',
                        ),
                      );
                    },
                    expand: true,
                    text: 'show modal',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
