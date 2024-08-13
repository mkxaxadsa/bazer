// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:finance/core/extensions/expanded_ext_on_widget.dart';
import 'package:finance/core/extensions/list_seperator_ext_on_list.dart';
import 'package:finance/core/extensions/padding_extension_on_widget.dart';
import 'package:flutter/material.dart';

class DiagramWidget extends StatelessWidget {
  const DiagramWidget({
    Key? key,
    required this.maxValue,
    required this.bottomLabels,
    required this.data,
  }) : super(key: key);
  final int maxValue;
  final List<String> bottomLabels;
  final List<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 230,
      decoration: ShapeDecoration(
        color: Colors.white10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(8, 20, 40, 8),
      child: Stack(
        children: [
          Positioned.fill(
            bottom: 60,
            child: Column(
              children: List<Widget>.generate(
                4,
                (index) => Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: Text(
                        "\$${(maxValue - (index * (maxValue / 4))).toInt()}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Row(
                      children: List<Widget>.generate(
                        25,
                        (index) => Container(
                          height: 1,
                          color: Colors.white,
                        ).expanded(),
                      ).separatedBy(
                        const SizedBox(
                          width: 6,
                        ),
                      ),
                    ).expanded(),
                  ],
                ),
              ).separatedBy(const Spacer()),
            ),
          ),
          Positioned.fill(
            left: 40,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 1,
                      color: Colors.white,
                      height: 185,
                    ),
                    Container(
                      color: Colors.white,
                      height: 1,
                    ).expanded(),
                  ],
                ).expanded(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    bottomLabels.length,
                    (index) => Text(
                      bottomLabels[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ).paddingOnly(top: 12, bottom: 4),
                  ),
                )
              ],
            ),
          ),
          Positioned.fill(
            left: 40,
            bottom: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                data.length,
                (index) {
                  final leftValue = data[index]["l"] as int? ?? 0;
                  final rightValue = data[index]["r"] as int? ?? 0;
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          if (maxValue - leftValue > 0)
                            Spacer(
                              flex: maxValue - leftValue,
                            ),
                          if (leftValue > 0)
                            Container(
                              width: 12,
                              color: const Color(0xFFDBC873),
                            ).expanded(flex: leftValue),
                        ],
                      ).paddingOnly(right: 5),
                      Column(
                        children: [
                          if (maxValue - rightValue > 0)
                            Spacer(
                              flex: maxValue - rightValue,
                            ),
                          if (rightValue > 0)
                            Container(
                              width: 12,
                              color: Colors.white,
                            ).expanded(flex: rightValue),
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
