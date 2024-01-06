import 'package:cuckoo_starter_kit/app/widgets/platform/activity_indicator.dart';
import 'package:cuckoo_starter_kit/app/widgets/platform/bottom_bar.dart';
import 'package:cuckoo_starter_kit/app/widgets/platform/navigation_bar.dart';
import 'package:cuckoo_starter_kit/app/widgets/platform/popup.dart';
import 'package:cuckoo_starter_kit/app/widgets/platform/switch.dart';
import 'package:cuckoo_starter_kit/app/widgets/platform/text_field.dart';
import 'package:cuckoo_starter_kit/app/widgets/platform/time_picker.dart';

abstract interface class IPlatformWidgetsFactory {
  INavigationBar createNavigationBar();
  IBottomBar createBottomBar();
  ISwitch createSwitch();
  IPopup createPopup();
  ITextField createTextField();
  ITimePicker createTimePicker();
  IActivityIndicator createActivityIndicator();
}

class AndroidWidgetsFactory implements IPlatformWidgetsFactory {
  const AndroidWidgetsFactory();

  @override
  INavigationBar createNavigationBar() => const AndroidNavigationBar();

  @override
  IBottomBar createBottomBar() => const AndroidBottomBar();

  @override
  ISwitch createSwitch() => const AndroidSwitch();

  @override
  IPopup createPopup() => const AndroidPopup();

  @override
  ITextField createTextField() => const AndroidTextField();

  @override
  ITimePicker createTimePicker() => const AndroidTimePicker();

  @override
  IActivityIndicator createActivityIndicator() =>
      const AndroidActivityIndicator();
}

class IosWidgetsFactory implements IPlatformWidgetsFactory {
  const IosWidgetsFactory();

  @override
  INavigationBar createNavigationBar() => const IosNavigationBar();

  @override
  IBottomBar createBottomBar() => const IosBottomBar();

  @override
  ISwitch createSwitch() => const IosSwitch();

  @override
  IPopup createPopup() => const IosPopup();

  @override
  ITextField createTextField() => const IosTextField();

  @override
  ITimePicker createTimePicker() => const IosTimePicker();

  @override
  IActivityIndicator createActivityIndicator() => const IosActivityIndicator();
}
