import '../../../../constants.dart';
import '../../../../shared/components/components.dart';
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
  Widget build(BuildContext context) 
  {
    
    return 
    BlocProvider(
      create: (BuildContext context) => AboutVersionCubit()..aboutUs(),
      child: 
        BlocConsumer<AboutVersionCubit, AboutVersionStates>(
          listener: (context, state) {
            if (state is AboutVersionInitialState) { }
            // if (state is AboutUsSuccessState) {
            // }
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
                body: 

                  Column(
                    children: [
                      SizedBox( height: 1.h,) ,
                      Container(
                        height: 10.h,
                        width: 20.w,
                        decoration:  BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: AssetImage('assets/icon.png', ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),

                      SizedBox( height: 2.h,) ,
                      
                      ListView.separated(
                        itemCount: AboutVersionCubit.get(context).splittingAboutUs.length,
                        separatorBuilder: (context,index)=>SizedBox(height: 1.5.h,),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        // mainAxisSize: MainAxisSize.min,
                      itemBuilder: (context,index)=>
                          Padding(
                            padding: EdgeInsetsDirectional.only(start: 2.h,bottom: 2.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.only(top: 1.h),
                                  child: Container(
                                      height: 1.h,
                                      width: 5.w,
                                      decoration: BoxDecoration(color: PRIMARY,shape: BoxShape.circle)),
                                ),
                                SizedBox(width: 0.2.w,),
                                Container(
                                  width: 88.w,
                                  child: Text(
                                    AboutVersionCubit.get(context).splittingAboutUs[index],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 132,
                                    textAlign: TextAlign.right,
                                    style: GoogleFonts.almarai( ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ),

                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.all(0),
                          children: [
                            _infoTile('App name', _packageInfo.appName),
                            _infoTile('Package name', _packageInfo.packageName, dir: TextDirection.ltr),
                            _infoTile('App version', _packageInfo.version + "+" +  _packageInfo.buildNumber, dir: TextDirection.ltr),
                            _infoTile('Server', BASE_URL, dir: TextDirection.ltr),
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
                                title: 
                                InkWell(
                                  onTap: () async 
                                  {
                                    Uri uri = Uri(
                                        scheme: "https",
                                        path: "//wa.me/966564599127");
                        
                                    if (await launchUrl(uri, mode: LaunchMode.platformDefault)) {
                                    } else {
                                      showToast(msg: 'Could not launch ${uri}', state: ToastStates.ERROR);
                                    }
                                  },
                                  child: Text("📞 +966-564599127 (Whatsapp)",
                                      style: GoogleFonts.almarai(
                                          color: PRIMARY, fontSize: 14.sp, fontWeight: FontWeight.bold)
                                      ),
                                ),
                              ),
                            ),
                        
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: ListTile(
                                title: InkWell(
                                  onTap: () async 
                                  {
                                    Uri uri = Uri(
                                        scheme: "https",
                                        path: "//samialfattani.github.io");
                        
                                    if (await launchUrl(uri, mode: LaunchMode.platformDefault)) {
                                    } else {
                                      showToast(msg: 'Could not launch ${uri}', state: ToastStates.ERROR);
                                    }
                                  },
                                  child: Text("🌐 https://samialfattani.github.io/",
                                      style: GoogleFonts.almarai(
                                          color: PRIMARY, fontSize: 14.sp)),
                                ),
                              ),
                            ),
                        
                          ],
                        ),
                      ),
                    ],
                  ),

              )),
        ),
    );
  }

  Widget _infoTile(String title, String subtitle, {TextDirection dir = TextDirection.rtl}) 
  {
    return 
    Directionality(
      textDirection: dir, 
      child: 
        ListTile(
          title: Text(
            title,
            style: TextStyle(
                color: BLACK, fontSize: 19.0, fontWeight: FontWeight.w700),
          ),
          subtitle: Text(subtitle.isEmpty ? '-------' : subtitle,
              style: GoogleFonts.almarai(color: BLACK_OPACITY, fontSize: 14.sp)),
        )      
    );
  }

}//end class

