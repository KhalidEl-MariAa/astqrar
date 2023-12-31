import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../shared/components/dialog_please_login.dart';
import '../../../constants.dart';
import '../../../shared/styles/colors.dart';
import '../0_favourites/favourites_tab.dart';
import '../1_notifications/notifications_tab.dart';
import '../2_home_tab/home_tab.dart';
import '../3_contacts/contacts_tab.dart';
import '../4_more/more_tab.dart';

class LayoutScreen extends StatefulWidget 
{
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  _LayoutScreenState createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> 
{
  int _selectedTab = 2;

  List widgetList = [
    FavouritesTab(),
    NotificationTab(),
    HomeTab(),
    ContactsTab(),
    MoreTab(),
  ];

  @override
  void initState() 
  {
    super.initState();

    //SplashCubit.Firebase_init( context );

  }

  @override
  Widget build(BuildContext context) 
  {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: floatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: createBottomAppBar(context),
        body: widgetList[_selectedTab],
      ),
    );
  }

  BottomAppBar createBottomAppBar(BuildContext context) 
  {
    return BottomAppBar(
      // clipBehavior: Clip.hardEdge ,    
      notchMargin: 9,
      elevation: 0,
      shape: CircularNotchedRectangle(),
      color: WHITE,
      child: 
        Container(
          // height: 20.h,
          color: WHITE,
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: .2.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  if (IS_LOGIN == false) {
                    showDialog(
                        context: context,
                        builder: (context) => DialogPleaseLogin());
                  }
                  setState(() { 
                    if(IS_LOGIN) _selectedTab = 0;
                  });
                },
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsetsDirectional.only(start: 1.8.w, top: 0.5.h),
                      child: Image.asset(
                        'assets/Favourite.png',
                        color: _selectedTab == 0 ? PRIMARY : CUSTOME_GREY,
                      ),
                    ),
                    Text(
                      "المفضلة"+"",
                      style: GoogleFonts.almarai(
                          color: _selectedTab == 0 ? PRIMARY : CUSTOME_GREY,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),

              InkWell(
                onTap: () {
                  if (IS_LOGIN == false) {
                    showDialog(
                        context: context,
                        builder: (context) => DialogPleaseLogin());
                  }

                  setState(() {
                    if (IS_LOGIN) _selectedTab = 1;
                  });
                },
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsetsDirectional.only(start: 1.8.w, top: 0.5.h),
                      child: 
                        Image.asset(
                          'assets/notification.png',
                          color: _selectedTab == 1 ? PRIMARY : CUSTOME_GREY
                        ),
                    ),
                    
                    SizedBox(height: 0.3.h,),

                    Text(
                      "الاشعارات",
                      style: GoogleFonts.almarai(
                          color: _selectedTab == 1 ? PRIMARY : CUSTOME_GREY,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),

              SizedBox(width: 48,),

              // ايقونة المحادثات
              InkWell(
                onTap: () {
                  if (IS_LOGIN == false) {
                    showDialog(
                        context: context,
                        builder: (context) => DialogPleaseLogin());
                  }
                  setState(() {
                    if (IS_LOGIN) {
                      _selectedTab = 3;
                    }
                  });
                },
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsetsDirectional.only(start: 1.8.w, top: 0.5.h),
                      child: Image.asset('assets/chat.png',
                          color: _selectedTab == 3 ? PRIMARY : CUSTOME_GREY),
                    ),
                    
                    SizedBox(height: 0.3.h,),
                    
                    Text(
                      "المحادثات",
                      style: GoogleFonts.almarai(
                          color: _selectedTab == 3 ? PRIMARY : CUSTOME_GREY,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),

              InkWell(
                onTap: () {
                  _selectedTab = 4;
                  setState(() {});
                },
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsetsDirectional.only(
                          start: 1.8.w, top: 0.5.h, end: 1.w),
                      child: Image.asset('assets/more.png',
                          color: _selectedTab == 4 ? PRIMARY : CUSTOME_GREY),
                    ),

                    SizedBox(height: 0.3.h),

                    Text(
                      "المزيد",
                      style: GoogleFonts.almarai(
                          color: _selectedTab == 4 ? PRIMARY : CUSTOME_GREY,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }

  FloatingActionButton floatingActionButton() 
  {
    return 
      FloatingActionButton(
        onPressed: () 
        {
          setState(() {
            _selectedTab = 2;
          });
        },
        child: 
          Container(
            width: 10.w,
            color: _selectedTab == 2 ? PRIMARY : WHITE,
            child: Image.asset(
              'assets/home.png',
              color: _selectedTab == 2 ? WHITE : CUSTOME_GREY
              ),
          ),
        backgroundColor: _selectedTab == 2 ? PRIMARY : WHITE,
      );
  }
}//------------------
