import 'package:finance/app/app.dart';
import 'package:finance/data/helpers/hive_helper.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper.init();
  runApp(const FinanceApp());
}