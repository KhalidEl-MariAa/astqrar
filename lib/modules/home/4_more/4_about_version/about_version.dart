import 'dart:developer';

import 'package:astarar/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../shared/components/logo/normal_logo.dart';
import '../../../../shared/styles/colors.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class AboutVersion extends StatefulWidget {
  final bool isFromLogin;

  AboutVersion({required this.isFromLogin});

  @override
  State<AboutVersion> createState() => _AboutVersionState();
}

class _AboutVersionState extends State<AboutVersion> {
  final formKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AboutVersionCubit(),
      child: BlocConsumer<AboutVersionCubit, AboutVersionStates>(
        listener: (context, state) {
          if (state is AboutVersionInitialState) {}
        },
        builder: (context, state) => Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(11.h),
                  child: NormalLogo(
                    appbarTitle: "عن هذا الإصدار",
                    isBack: true,
                  )),
              body: ListView(
                children: <Widget>[
                  _infoTile('App name', _packageInfo.appName),
                  _infoTile('Package name', _packageInfo.packageName),
                  _infoTile('App version', _packageInfo.version),
                  _infoTile('Build number', _packageInfo.buildNumber),
                  // _infoTile('Build signature', _packageInfo.buildSignature),
                  // _infoTile('Installer store', _packageInfo.installerStore ?? 'not available',),
                  _infoTile("برمجة وإعداد", "م/ سامي الفتني"),

                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: ListTile(
                      title: Text("📧 Sami_alfattani@hotmail.com",
                          style: GoogleFonts.almarai(
                              color: BLACK_OPACITY, fontSize: 14.sp)),
                    ),
                  ),

                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: ListTile(
                      title: Text("📞 +966-564599127",
                          style: GoogleFonts.almarai(
                              color: BLACK_OPACITY, fontSize: 14.sp)),
                    ),
                  ),

                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: ListTile(
                      title: InkWell(
                        onTap: () async {
                          Uri uri = Uri(
                              scheme: "https",
                              path: "//samialfattani.github.io");
                          
                          log("SAMI_CV : " + uri.toString());

                          if (await launchUrl(uri, mode: LaunchMode.platformDefault)) {
                          } else {
                            showToast(msg: 'Could not launch ${uri}', state: ToastStates.ERROR);
                          }
                        },
                        child: Text("🌐 https://samialfattani.github.io/",
                            style: GoogleFonts.almarai(
                                color: PRIMARY, fontSize: 14.sp, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  Widget _infoTile(String title, String subtitle) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
            color: BLACK, fontSize: 19.0, fontWeight: FontWeight.w700),
      ),
      subtitle: Text(subtitle.isEmpty ? '-------' : subtitle,
          style: GoogleFonts.almarai(color: BLACK_OPACITY, fontSize: 14.sp)),
    );
  }
}
