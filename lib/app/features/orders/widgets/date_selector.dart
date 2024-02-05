import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:orders_accountant/app/features/orders/cubit/orders_cubit.dart';
import 'package:orders_accountant/core/constants/common_libs.dart';

class DateSelector extends StatefulWidget {
  const DateSelector({super.key});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime date = DateTime.now();

  dateSelected(DateTime date) {
    context.read<OrdersCubit>().dateSelected(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 4),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  date = date.subtract(const Duration(days: 1));
                });
                dateSelected(date);
              },
              child: Container(
                alignment: Alignment.center,
                width: 28,
                height: 28,
                child:
                    Icon(Icons.arrow_back_ios_rounded, color: colors.steelGrey),
              ),
            ),
            Container(width: 10),
            Expanded(
              child: InkWell(
                onTap: () async {
                  // final DateTime picked = await showDatePicker(
                  //     context: context,
                  //     initialDate: date,
                  //     locale: const Locale("ru", "RU"),
                  //     firstDate: DateTime(2015, 8),
                  //     lastDate: DateTime(2101));
                  // if (picked != null && picked != date)
                  //   setState(() {
                  //     date = picked;
                  //   });
                  // subscribeToDate(date);
                },
                child: Container(
                  //width: 271,
                  height: 45,
                  padding: const EdgeInsets.only(left: 16, right: 14),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border:
                          Border.all(width: 1.5, color: colors.periwinkleBlue),
                      color: colors.white),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${dayNames[date.weekday - 1]}, ${date.day} ${monthNames[date.month - 1]}',
                          style: textStyles.body.semiBold.c(colors.steelGrey),
                        ),
                      ),
                      const Gap(10),
                      Icon(Icons.calendar_today_rounded,
                          color: colors.steelGrey)
                    ],
                  ),
                ),
              ),
            ),
            Container(width: 10),
            InkWell(
              onTap: () {
                setState(() {
                  date = date.add(const Duration(days: 1));
                });
                dateSelected(date);
              },
              child: Container(
                alignment: Alignment.center,
                width: 28,
                height: 28,
                child: Icon(Icons.arrow_forward_ios_rounded,
                    color: colors.steelGrey),
              ),
            ),
          ],
        ));
  }
}

//Ukrainian

const dayNames = [
  'Понеділок',
  'Вівторок',
  'Середа',
  'Четвер',
  'П\'ятниця',
  'Субота',
  'Неділя',
];

const monthNames = [
  'січня',
  'лютого',
  'березня',
  'квітня',
  'травня',
  'червня',
  'липня',
  'серпня',
  'вересня',
  'жовтня',
  'листопада',
  'грудня'
];

const monthNames2 = [
  'Січень',
  'Лютий',
  'Березень',
  'Квітень',
  'Травень',
  'Червень',
  'Липень',
  'Серпень',
  'Вересень',
  'Жовтень',
  'Листопад',
  'Грудень'
];
