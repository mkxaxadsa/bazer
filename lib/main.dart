import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:finance/app/app.dart';
import 'package:finance/data/helpers/hive_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

import 'features/welcome/firebase_options.dart';

late AppsflyerSdk fsdfdsf;
String mfdks = '';
bool inias = false;
String mdjas = '';
String fnjksd = '';
String modaslmdsa = '';
String njfksd = '';
String dsfsdfdsf = '';
Map njdkasdnsajk = {};
String mklfsdlfsd = '';
Map njkfnsdkxkds = {};
bool fmjsdkfnjksd = false;
String mfkdmslksdf = '';
String ndjaksdnkas = '';
String lkfosdpfsd = '';
String mklfmsfsfdlsmflksdf = '';
String df = '';
String fmnsdjkfnsd = '';
String fsdfds = '';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppTrackingTransparency.requestTrackingAuthorization();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 25),
    minimumFetchInterval: const Duration(seconds: 25),
  ));
  await FirebaseRemoteConfig.instance.fetchAndActivate();
  await HiveHelper.init();
  djsifds();
  runApp(const FinanceApp());
}

Future<void> init1() async {
  final AppsFlyerOptions nfjksdfkds = AppsFlyerOptions(
    showDebug: false,
    afDevKey: '4rYehnSYQsVcM2jmim5KyC',
    appId: '6633428342',
    timeToWaitForATTUserAuthorization: 15,
    disableAdvertisingIdentifier: false,
    disableCollectASA: false,
    manualStart: true,
  );
  fsdfdsf = AppsflyerSdk(nfjksdfkds);

  await fsdfdsf.initSdk(
    registerConversionDataCallback: true,
    registerOnAppOpenAttributionCallback: true,
    registerOnDeepLinkingCallback: true,
  );

  fsdfdsf.onAppOpenAttribution((res) {
    // setState(() {
    //   mfklsdmfkldsf = res;
    //   modaslmdsa = res['payload']
    //       .entries
    //       .where((e) => ![
    //             'install_time',
    //             'click_time',
    //             'af_status',
    //             'is_first_launch'
    //           ].contains(e.key))
    //       .map((e) => '&${e.key}=${e.value}')
    //       .join();
    //   klmdaslmfdlsa = '&campaign=${res['campaign'] ?? ''}';
    //   lkfosdpfsd = '&media_source=${res['media_source'] ?? ''}';
    // });
  });

  fsdfdsf.onInstallConversionData((res) {
    njkfnsdkxkds = res;
    fmjsdkfnjksd = res['payload']['is_first_launch'];
    mfkdmslksdf = res['payload']['af_status'];
    mdjas = '&is_first_launch=$fmjsdkfnjksd&af_status=$mfkdmslksdf';
  });

  fsdfdsf.onDeepLinking((DeepLinkResult dp) {
    switch (dp.status) {
      case Status.FOUND:
        print(dp.deepLink?.toString());
        print("deep link value: ${dp.deepLink?.deepLinkValue}");
        break;
      case Status.NOT_FOUND:
        print("deep link not found");
        break;
      case Status.ERROR:
        print("deep link error: ${dp.error}");
        break;
      case Status.PARSE_ERROR:
        print("deep link status parsing error");
        break;
    }
    print("onDeepLinking res: " + dp.toString());

    njdkasdnsajk = dp.toJson();
  });
  fsdfdsf.startSDK(
    onSuccess: () {
      print("AppsFlyer SDK initialized successfully.");
    },
  );
}

Future<String> djsifds() async {
  String fndsjkfs = await AppTrackingTransparency.getAdvertisingIdentifier();
  init1();
  return fndsjkfs;
}
