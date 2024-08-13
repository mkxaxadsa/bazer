import 'package:finance/core/constants/app_icons.dart';
import 'package:finance/core/extensions/align_ext_on_widget.dart';
import 'package:finance/core/extensions/expanded_ext_on_widget.dart';
import 'package:finance/core/extensions/padding_extension_on_widget.dart';
import 'package:finance/core/ui_components/action_button.dart';
import 'package:finance/core/ui_components/bottomsheets/add_transaction.dart';
import 'package:finance/data/helpers/hive_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 20),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _titleBlock(
              title: "Your balance",
              subtitle: "\$${HiveHelper.balance}",
            ),
            _titleDivider(AppIcons.income),
            _titleBlock(
              title: "Income",
              subtitle: "\$${HiveHelper.income}",
            ),
            _titleDivider(AppIcons.expense),
            _titleBlock(
              title: "Expense",
              subtitle: "\$${HiveHelper.expense}",
            ),
          ],
        ).paddingOnly(bottom: 40),
        GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 40,
            crossAxisSpacing: 8,
            mainAxisSpacing: 12,
          ),
          shrinkWrap: true,
          primary: false,
          children: [
            ActionButton(
              text: "Add income",
              onTap: () {
                showIncomeBottomsheet(
                  context,
                  (tr) {
                    HiveHelper.addTransaction(tr).then((value) {
                      setState(() {});
                    });
                  },
                );
              },
              isSelected: false,
            ),
            ActionButton(
              text: "Add Expense",
              onTap: () {
                showExpenseBottomsheet(
                  context,
                  (tr) {
                    HiveHelper.addTransaction(tr).then((value) {
                      setState(() {});
                    });
                  },
                );
              },
              isSelected: false,
            ),
            ActionButton(
              text: "History",
              onTap: () {
              },
            ),
          ],
        ).paddingOnly(bottom: 23),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 150,
              mainAxisSpacing: 12,
              crossAxisSpacing: 8,
            ),
            shrinkWrap: true,
            primary: false,
            itemCount: HiveHelper.transactions.length,
            itemBuilder: (context, index) {
              final tr = HiveHelper.transactions[index];
              return Container(
                decoration: ShapeDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffB85C19),
                      ),
                      child: Image.asset(tr.category.asset),
                    ).paddingOnly(bottom: 3),
                    Text(
                      tr.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '\$${tr.amount}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Wrap(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 6),
                          decoration: ShapeDecoration(
                            color:
                                Colors.white.withOpacity(0.10000000149011612),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                          child: Text(
                            tr.category.viewText,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 6),
                          decoration: ShapeDecoration(
                            color:
                                Colors.white.withOpacity(0.10000000149011612),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                          child: Text(
                            tr.typeViewText,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ).paddingSymetric(vertical: 8),
              );
            },
          ),
      ],
    );
  }

  Widget _titleBlock({
    required String title,
    required String subtitle,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ).paddingOnly(bottom: 4),
        Text(
          subtitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ).align().expanded();
  }

  Widget _titleDivider(String icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 2,
          height: 29,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
        ).paddingOnly(right: 6),
        Image.asset(
          icon,
          width: 11,
          height: 11,
        ),
      ],
    );
  }
}
