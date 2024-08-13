// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:finance/core/constants/app_icons.dart';
import 'package:finance/core/extensions/expanded_ext_on_widget.dart';
import 'package:finance/core/extensions/mediaquery_ext_on_context.dart';
import 'package:finance/core/extensions/padding_extension_on_widget.dart';
import 'package:flutter/material.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({
    Key? key,
    required this.currentPageIndex,
    required this.onChanged,
  }) : super(key: key);
  final int currentPageIndex;
  final void Function(int pageIndex) onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: const Color(0xffD9D9D9).withOpacity(.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      padding: EdgeInsets.only(top: 16, bottom: context.padding.bottom + 16),
      child: Row(
        children: [
          _item(
            icon: AppIcons.home,
            label: "Home",
            index: 0,
          ),
          _item(
            icon: AppIcons.news,
            label: "News",
            index: 1,
          ),
          _item(
            icon: AppIcons.statistics,
            label: "Statistics",
            index: 2,
          ),
          _item(
            icon: AppIcons.settings,
            label: "Settings",
            index: 3,
          ),
        ],
      ),
    );
  }

  Widget _item({
    required String icon,
    required String label,
    required int index,
  }) {
    final isSelected = index == currentPageIndex;
    return GestureDetector(
      onTap: () {
        onChanged(index);
      },
      child: Container(
        color: Colors.transparent,
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              icon,
              width: 24,
              color: isSelected ? const Color(0xffB3935B) : Colors.white,
            ).paddingOnly(bottom: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                color: isSelected ? const Color(0xffB3935B) : Colors.white,
              ),
            )
          ],
        ),
      ),
    ).expanded();
  }
}
