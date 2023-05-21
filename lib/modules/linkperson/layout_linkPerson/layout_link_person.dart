import 'package:astarar/modules/chats/chat.dart';
import 'package:astarar/modules/favourite/favourite_screen.dart';
import 'package:astarar/modules/home/home.dart';
import 'package:astarar/modules/linkperson/update_price/cubit/cubit.dart';
import 'package:astarar/modules/linkperson/update_price/update_price.dart';
import 'package:astarar/modules/more/more_screen.dart';
import 'package:astarar/modules/search/result.dart';
import 'package:astarar/notifications/notifications_screen.dart';
import 'package:astarar/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LayoutLinkPerson extends StatefulWidget 
{
  const LayoutLinkPerson({Key? key}) : super(key: key);

  @override
  _LayoutLinkPersonState createState() => _LayoutLinkPersonState();
}

class _LayoutLinkPersonState extends State<LayoutLinkPerson> {
  int _selectedIndex = 2;
  List widgetList = [
    ResultScreen(),
    NotificationScreen(),
    UserHomeScreen(),
    ChatScreen(),
    MoreScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: floatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          clipBehavior: Clip.antiAlias,
          notchMargin: 9,
          elevation: 10,
          shape: const CircularNotchedRectangle(),
          color: Color(0xff021222),
          child: Container(
            height: 9.h,
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {

                      _selectedIndex = 0;

                    showDialog(context: context, builder: (context) =>UpdatePrice(
                    ));

                  },
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsetsDirectional.only(
                            start: 1.8.w, top: 0.2.h),
                        child: Icon(
                          Icons.monetization_on,
                          color: _selectedIndex == 0
                              ? primary
                              : Color(0xff707B81),


                        ),
                      ),
                      //  SizedBox(height: 0.3.h,),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 0.5.w),
                        child: Text("السعر", style: TextStyle(
                            color: _selectedIndex == 0
                                ? primary
                                : const Color(0xff707B81),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600),),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                    _selectedIndex = 1;
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsetsDirectional.only(
                            start: 1.8.w, top: 0.5.h),
                        child: Image.asset('assets/notification.png',
                            color: _selectedIndex == 1
                                ? primary
                                : customGrey),
                      ),
                      SizedBox(height: 0.3.h,),
                      Text(
                        "الاشعارات", style: TextStyle(color: _selectedIndex == 1
                          ? primary
                          : Color(0xff707B81),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600),)
                    ],
                  ),
                ),
                SizedBox(
                  width: 48,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      {
                        _selectedIndex = 3;
                      }
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsetsDirectional.only(
                            start: 1.8.w, top: 0.5.h),
                        child: Image.asset('assets/chat.png',
                            color: _selectedIndex == 3
                                ? primary
                                : customGrey),
                      ),
                      SizedBox(height: 0.3.h,),
                      Text(
                        "المحادثات", style: TextStyle(color: _selectedIndex == 3
                          ? primary
                          : customGrey,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600),)
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _selectedIndex = 4;
                    setState(() {});
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsetsDirectional.only(
                            start: 1.8.w, top: 0.5.h, end: 1.w),
                        child: Image.asset('assets/more.png',
                            color: _selectedIndex == 4
                                ? primary
                                : customGrey),
                      ),
                      SizedBox(height: 0.3.h),
                      Text("المزيد", style: TextStyle(color: _selectedIndex == 4
                          ? primary
                          : customGrey,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600),)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: widgetList[_selectedIndex],
      ),
    );
  }

  FloatingActionButton floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          _selectedIndex = 2;
        });
        //  Navigator.push(context, MaterialPageRoute(builder: (context)=>CommonProducts()));
      },

      child: Container(
        width: 10.w,
        color: primary,
        child: Image.asset('assets/home.png'),
      ),
      backgroundColor: primary,
    );
  }
}

