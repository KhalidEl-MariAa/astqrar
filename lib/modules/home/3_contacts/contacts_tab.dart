import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../models/user_contact.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/favourite_item.dart';
import '../../../shared/components/loading_gif.dart';
import '../../../shared/components/logo/normal_logo.dart';
import '../../../shared/styles/colors.dart';
import '../../chatt/chatt.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class ContactsTab extends StatefulWidget 
{

  ContactsTab({Key? key}) : super(key: key);

  @override
  State<ContactsTab> createState() => _ContactsTabState();
}

class _ContactsTabState extends State<ContactsTab> 
{
  late List<Contact> contacts;

  @override
  Widget build(BuildContext context) 
  {
    return BlocProvider(
      create: (BuildContext context) => ContactsCubit()..getContacts(),

      child: BlocConsumer<ContactsCubit, ContactsStates>(
        listener: (context, state) 
        {
          if (state is GetContactsSuccessState){
            this.contacts = state.contacts;
          }
          if (state is RemoveChatSuccessState) {
              showToast( msg: "تم حذف المحادثة بنجاح", state: ToastStates.SUCCESS);
          }
        },
        builder: (context, state) => Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              backgroundColor: WHITE,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(100),
                  child: NormalLogo(
                    appbarTitle: "المحادثات",
                    isBack: false,
                  )),

              body: ConditionalBuilder(
                condition: state is GetContactsLoadingState,
                builder: (context) => LoadingGif(),
                fallback: (context) => Padding(
                  padding: const EdgeInsetsDirectional.only(top: 20),
                  child: 
                    Column(
                      children: [
                        if(this.contacts.length == 0)
                          Row(                          
                            children: [
                              SizedBox(width: 5.w,),
                              Text("لا توجد محادثات حالياً", 
                                style: GoogleFonts.almarai(color: CUSTOME_GREY, fontSize: 20.sp),
                              ),
                            ],
                          ),

                        if(this.contacts.length >= 1)
                          Row(                          
                            children: [
                              SizedBox(width: 2.w,),
                              Icon(Icons.delete, color: Colors.red,),
                              Text("لحذف المحادثة اسحب لليسار", 
                                style: GoogleFonts.almarai(color: CUSTOME_GREY, fontSize: 11.sp),
                              ),
                              
                              Icon(Icons.arrow_forward_rounded, color: PRIMARY,),
                            ],
                          ),

                        Expanded(
                          child: 
                            ListView.separated(
                              separatorBuilder: (context, index) => SizedBox( height: 0.5.h,),
                              itemCount: this.contacts.length,
                              itemBuilder: (context, index) => 
                                ConditionalBuilder(
                                  condition: state is RemoveChatLoadingState && state.index == index,
                                  builder: (context) => 
                                    Container(
                                      alignment: Alignment.topLeft,
                                      height: 8.5.h,
                                      width: 5,
                                      child: LoadingGif(),
                                    ),
                                    
                                  fallback: (context) =>
                                    // عنصر اللستة القابل للحذف لكل مستخدم
                                    Dismissible(
                                      key: UniqueKey(),
                                      onResize: () 
                                      {
                                        ContactsCubit.get(context).removeChat(
                                            userId: ContactsCubit.get(context)
                                                .contacts[index]
                                                .contactorId,
                                            index: index);
                                      },
                                      
                                      background: Container(
                                        color: PRIMARY,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.only(
                                                  start: MediaQuery.of(context).size.width * 0.055),

                                              child: Icon( Icons.delete_outline, color: WHITE ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      
                                      child: 
                                        // الصورة والاسم
                                        FavouriteItem (
                                          contactor: this.contacts[index], 
                                          onClicked: () { user_on_click(context, index); },
                                          widget: 
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [

                                                SizedBox(height: 1.h,),

                                                // تاريخ الكونتاكت
                                                Text(
                                                  this.contacts[index].time!,
                                                  style: GoogleFonts.poppins(color: CUSTOME_GREY, fontSize: 10.sp),
                                                ),

                                                SizedBox(height: 0.5.h,),
                                                
                                                // ايقونة شات
                                                if( this.contacts[index].unseenMsgCount > 0 )
                                                  Chip(
                                                    padding: EdgeInsets.all(0.0),
                                                    shape: RoundedRectangleBorder(
                                                      side: BorderSide(width: 1.0, color: PRIMARY ),
                                                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                                                    backgroundColor: PRIMARY,
                                                    label: Text(this.contacts[index].unseenMsgCount.toString(), 
                                                            style: GoogleFonts.almarai(
                                                              color: WHITE, 
                                                              backgroundColor: PRIMARY,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 14 ),),
                                                  ),
                                            ],),

                                        ),
                                    ),

                                )
                            ),

                        )
                      ],
                    )
                  ),
                ),
              )),
        ),
    );
  }

  void user_on_click(BuildContext context, int index) 
  {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => 
                ConversationScreen.byOtherId(
                      otherId: this.contacts[index].contactorId)
        )
      );

  }
}
