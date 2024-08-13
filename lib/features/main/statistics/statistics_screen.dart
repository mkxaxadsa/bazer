import 'package:finance/core/constants/weekdays.dart';
import 'package:finance/core/extensions/expanded_ext_on_widget.dart';
import 'package:finance/core/extensions/format_ext_on_datetime.dart';
import 'package:finance/core/extensions/padding_extension_on_widget.dart';
import 'package:finance/core/ui_components/action_button.dart';
import 'package:finance/data/helpers/hive_helper.dart';
import 'package:finance/data/models/expense_transaction.dart';
import 'package:finance/data/models/income_transaction.dart';
import 'package:finance/features/main/statistics/components/diagram_widget.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int currentRangeIndex = 0;

  final dayLabels = [weekdays[DateTime.now().weekday - 1]];

  List<String> weekLabels = [];

  List<String> monthLabels = [];

  late final List<Map<String, dynamic>> dayValues;

  late final List<Map<String, dynamic>> weekValues;

  late final List<Map<String, dynamic>> monthValues;

  int dayIncome = 0;
  int dayExpense = 0;

  int weekIncome = 0;
  int weekExpense = 0;

  int monthIncome = 0;
  int monthExpense = 0;

  @override
  void initState() {
    super.initState();

    dayValues = getValueData(HiveHelper.todayIncoms, HiveHelper.todayExpenses);
    weekValues =
        getValueData(HiveHelper.lastWeekIncomes, HiveHelper.lastWeekExpenses);
    monthValues =
        getValueData(HiveHelper.lastMonthIncomes, HiveHelper.lastMonthExpenses);

    weekLabels = weekValues.map((val) {
      final dateTime = val["date_time"];
      if (dateTime is DateTime) {
        return weekdays[dateTime.weekday - 1];
      } else {
        return "N/A"; // Or any default value you prefer
      }
    }).toList();

    monthLabels =
        List.generate(monthValues.length, (index) => "Week ${index + 1}");

    for (final val in dayValues) {
      dayIncome += (val["l"] ?? 0) as int;
      dayExpense += (val["r"] ?? 0) as int;
    }

    for (final val in weekValues) {
      weekIncome += (val["l"] ?? 0) as int;
      weekExpense += (val["r"] ?? 0) as int;
    }

    for (final val in monthValues) {
      monthIncome += (val["l"] ?? 0) as int;
      monthExpense += (val["r"] ?? 0) as int;
    }
  }

  List<Map<String, dynamic>> getValueData(
    List<List<IncomeTransactionModel>> incomes,
    List<List<ExpenseTransactionModel>> expenses,
  ) {
    final Map<String, Map<String, dynamic>> map = {};

    // Process expenses
    for (final a in expenses) {
      if (a.isNotEmpty) {
        int exp = a.fold(0, (sum, item) => sum + item.amount);
        String key = a.first.dateTime.ymd.simpleFormat;
        map[key] = map[key] ?? {};
        map[key]?["r"] = exp;
        map[key]?["date_time"] = a.first.dateTime;
        map[key]?["l"] = 0;
      }
    }

    // Process incomes
    for (final a in incomes) {
      if (a.isNotEmpty) {
        int inc = a.fold(0, (sum, item) => sum + item.amount);
        String key = a.first.dateTime.ymd.simpleFormat;
        map[key] = map[key] ?? {};
        map[key]?["l"] = inc;
      }
    }

    return map.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 16),
      children: [
        const Text(
          'Activities',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ).paddingOnly(bottom: 45),
        Row(
          children: [
            ActionButton(
              text: "Day",
              onTap: () {
                setState(() {
                  currentRangeIndex = 0;
                });
              },
              isSelected: currentRangeIndex == 0,
            ).expanded(),
            const SizedBox(
              width: 4,
            ),
            ActionButton(
              text: "Week",
              onTap: () {
                setState(() {
                  currentRangeIndex = 1;
                });
              },
              isSelected: currentRangeIndex == 1,
            ).expanded(),
            const SizedBox(
              width: 4,
            ),
            ActionButton(
              text: "Month",
              onTap: () {
                setState(() {
                  currentRangeIndex = 2;
                });
              },
              isSelected: currentRangeIndex == 2,
            ).expanded(),
          ],
        ).paddingOnly(bottom: 30),
        DiagramWidget(
          maxValue: 14000,
          bottomLabels: currentRangeIndex == 0
              ? dayLabels
              : currentRangeIndex == 1
                  ? weekLabels
                  : monthLabels,
          data: currentRangeIndex == 0
              ? dayValues
              : currentRangeIndex == 1
                  ? weekValues
                  : monthValues,
        ).paddingOnly(bottom: 22),
        Container(
          width: double.maxFinite,
          height: 40,
          decoration: ShapeDecoration(
            color: Colors.white.withOpacity(0.10000000149011612),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const ShapeDecoration(
                  color: Color(0xFFDBC873),
                  shape: OvalBorder(),
                ),
              ).paddingOnly(right: 8),
              const Text(
                'Income',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ).expanded(),
              Text(
                '\$ ${currentRangeIndex == 0 ? dayIncome : currentRangeIndex == 1 ? weekIncome : monthIncome}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ).paddingOnly(left: 8, right: 38),
        ).paddingOnly(bottom: 12),
        Container(
          width: double.maxFinite,
          height: 40,
          decoration: ShapeDecoration(
            color: Colors.white.withOpacity(0.10000000149011612),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const ShapeDecoration(
                  color: Color(0xFFD9D9D9),
                  shape: OvalBorder(),
                ),
              ).paddingOnly(right: 8),
              const Text(
                'Expense',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ).expanded(),
              Text(
                '\$ ${currentRangeIndex == 0 ? dayExpense : currentRangeIndex == 1 ? weekExpense : monthExpense}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ).paddingOnly(left: 8, right: 38),
        ).paddingOnly(bottom: 12),
        Container(
          width: double.maxFinite,
          height: 40,
          decoration: ShapeDecoration(
            color: Colors.white.withOpacity(0.10000000149011612),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            children: [
              const Text(
                'Total amount',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ).expanded(),
              Text(
                '\$ ${HiveHelper.income + HiveHelper.expense}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ).paddingOnly(left: 8, right: 38),
        ).paddingOnly(bottom: 12),
      ],
    );
  }
}
