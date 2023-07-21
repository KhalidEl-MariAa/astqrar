import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../models/contacts.dart';
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
  late List<ContactDetails> contacts;

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
                                Dismissible(
                                  key: UniqueKey(),
                                  onDismissed: (value) 
                                  {
                                    ContactsCubit.get(context).removeChat(
                                        userId: ContactsCubit.get(context)
                                            .contacts[index]
                                            .userInformation!
                                            .id??"");
                                  },
                                  background: Container(
                                    color: PRIMARY,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional.only(
                                              start: MediaQuery.of(context).size.width * 0.055),

                                          child: Icon( Icons.delete_outline, color: WHITE,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                  // 
                                  child: 
                                    Stack(
                                      children: [
                                        if (state is RemoveChatLoadingState)
                                          Positioned.fill(
                                            child: Container(
                                              color: Colors.black54,
                                              child: Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                            ),
                                          ),
                                        
                                        FavouriteItem(
                                          widget: 
                                            Column(children: [
                                              SizedBox(height: 2.h,),
                                              Text(
                                                this.contacts[index].contact!.time!,
                                                style: GoogleFonts.poppins(color: CUSTOME_GREY, fontSize: 10.sp),
                                              ),
                                              SizedBox(height: 2.h,),

                                              // ايقونة شات
                                              Row(
                                                children: [
                                                  Icon(Icons.chat, color: PRIMARY,),
                                                  SizedBox(width: 6.w,),

                                                ],
                                              )
                                            ],),

                                          otherId: this.contacts[index].userInformation!.id!,
                                          name: this.contacts[index].userInformation == null? 
                                                "مستخدم"
                                                : 
                                                this.contacts[index].userInformation!.user_Name! 
                                                + " " ,
                                                // this.contacts[index].userInformation!.IsConnected.toString(),
                                          
                                          gender: this.contacts[index].userInformation!.gender!,
                                          
                                          onClicked: () { user_on_click(context, index); },
                                        ),

                                    ],)
                                ),
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
    if (this.contacts[index].userInformation != null ) 
    {
      

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => 
                ConversationScreen.byOtherId(
                          otherId: this.contacts[index]
                                      .userInformation!
                                      .id??"")
        )
      );

    }

  }
}
