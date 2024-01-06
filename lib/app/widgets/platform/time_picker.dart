import 'package:orders_accountant/core/constants/common_libs.dart';
import 'package:flutter/cupertino.dart';

abstract interface class ITimePicker {
  Widget render({
    required TimeOfDay startTime,
    required void Function(TimeOfDay) onChanged,
  });
}

class AndroidTimePicker implements ITimePicker {
  const AndroidTimePicker();

  @override
  Widget render({
    required TimeOfDay startTime,
    required void Function(TimeOfDay) onChanged,
  }) {
    TimeOfDay selected = startTime;
    return Stack(
      fit: StackFit.expand,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 100,
            child: ListWheelScrollView(
              onSelectedItemChanged: (hour) {
                TimeOfDay t = TimeOfDay(hour: hour, minute: selected.minute);
                selected = t;
                onChanged(t);
              },
              diameterRatio: 10,
              controller:
                  FixedExtentScrollController(initialItem: startTime.hour),
              physics: const FixedExtentScrollPhysics(),
              itemExtent: 40,
              overAndUnderCenterOpacity: 0.5,
              children: [
                for (int i = 0; i < 24; i++)
                  Center(
                    child: Text(
                      i.toString().padLeft(2, '0'),
                      style: textStyles.title,
                    ),
                  ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            ':',
            style: textStyles.title,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: 100,
            child: ListWheelScrollView(
              diameterRatio: 10,
              controller:
                  FixedExtentScrollController(initialItem: startTime.minute),
              physics: const FixedExtentScrollPhysics(),
              itemExtent: 40,
              onSelectedItemChanged: (minute) {
                TimeOfDay t = TimeOfDay(hour: selected.hour, minute: minute);
                selected = t;
                onChanged(t);
              },
              overAndUnderCenterOpacity: 0.5,
              children: [
                for (int i = 0; i < 60; i++)
                  Center(
                    child: Text(
                      i.toString().padLeft(2, '0'),
                      style: textStyles.title,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class IosTimePicker implements ITimePicker {
  const IosTimePicker();

  @override
  Widget render(
      {required TimeOfDay startTime,
      required void Function(TimeOfDay) onChanged}) {
    return CupertinoDatePicker(
      mode: CupertinoDatePickerMode.time,
      use24hFormat: true,
      onDateTimeChanged: (DateTime d) {},
    );
  }
}
