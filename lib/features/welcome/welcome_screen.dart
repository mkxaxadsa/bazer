import 'package:finance/app/global_navigator/global_navigator.dart';
import 'package:finance/core/constants/app_images.dart';
import 'package:finance/core/extensions/align_ext_on_widget.dart';
import 'package:finance/core/extensions/expanded_ext_on_widget.dart';
import 'package:finance/core/extensions/padding_extension_on_widget.dart';
import 'package:finance/data/helpers/hive_helper.dart';
import 'package:finance/features/main/main_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: [Color(0xFF0D2144), Color(0xFF1B3D7A)],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: SafeArea(
              child: Column(
                children: [
                  const Spacer(
                    flex: 2,
                  ),
                  const Text(
                    'Everything You Need - All in One App',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFFAFAFA),
                      fontSize: 28,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ).paddingSymetric(horizontal: 12).paddingOnly(top: 32),
                  const Text(
                    'Track your income and expenses, plan your budget, and get up-to-date information on currency and cryptocurrency exchange rates.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFFAFAFA),
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w300,
                    ),
                  ).paddingLTRB(12, 14, 12, 0),
                  Image.asset(
                    AppImages.welcome,
                    width: 250,
                  )
                      .paddingOnly(left: 44, bottom: 30, top: 30)
                      .align(Alignment.centerLeft),
                  GestureDetector(
                    onTap: () {
                      HiveHelper.setIsNotFirstTimeOpen();
                      GlobalNavigator.pushAndRemoveUntil(context,
                          page: const MainScreen());
                    },
                    child: Container(
                      width: double.maxFinite,
                      height: 40,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFB3883B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Get started',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ).paddingSymetric(horizontal: 20),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
