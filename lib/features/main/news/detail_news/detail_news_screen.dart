// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:finance/core/extensions/align_ext_on_widget.dart';
import 'package:finance/core/extensions/expanded_ext_on_widget.dart';
import 'package:finance/core/extensions/mediaquery_ext_on_context.dart';
import 'package:finance/core/extensions/padding_extension_on_widget.dart';
import 'package:finance/data/models/news_item_model.dart';

class DetailNewsScreen extends StatefulWidget {
  const DetailNewsScreen({
    Key? key,
    required this.item,
  }) : super(key: key);
  final NewsItemModel item;
  @override
  State<DetailNewsScreen> createState() => _DetailNewsScreenState();
}

class _DetailNewsScreenState extends State<DetailNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0e2348),
      body: SafeArea(
        bottom: false,
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          margin: const EdgeInsets.only(top: 28),
          padding: EdgeInsets.fromLTRB(16, 18, 16, 18 + context.padding.bottom),
          decoration: const ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 45,
                  ),
                  Text(
                    widget.item.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ).align().expanded(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Close',
                      style: TextStyle(
                        color: Color(0xFFB3935B),
                        fontSize: 16,
                        fontFamily: 'SF Pro Text',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ).paddingOnly(bottom: 30),
              Text(
                widget.item.text,
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
