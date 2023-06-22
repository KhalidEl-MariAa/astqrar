import 'cubit/cubit.dart';
import 'cubit/states.dart';
import '../details_user/cubit/cubit.dart';
import '../details_user/details_user.dart';
import '../../shared/components/components.dart';
import '../../shared/components/favourite_item.dart';
import '../../shared/components/loading_gif.dart';
import '../../shared/components/logo/normal_logo.dart';
import '../../shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ChatListScreen extends StatelessWidget 
{
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ContactsCubit()..getContacts(),
      child: BlocConsumer<ContactsCubit, ContactsStates>(
        listener: (context, state) {
          if (state is RemoveChatSuccessState) {
            if (state.statusCode == 200) {
              showToast(
                  msg: "تم حذف المحادثة بنجاح", state: ToastStates.SUCCESS);
            }
          }
        },
        builder: (context, state) => Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              backgroundColor: white,
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
                  child: ListView.separated(
                      itemBuilder: (context, index) => 
                        Dismissible(
                          key: UniqueKey(),
                          onDismissed: (value) {
                            ContactsCubit.get(context).removeChat(
                                userId: ContactsCubit.get(context)
                                    .contacts[index]
                                    .userInformation!
                                    .id!);
                          },
                          background: Container(
                            color: primary,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: MediaQuery.of(context).size.width *
                                          0.055),
                                  child: Icon(
                                    Icons.delete_outline,
                                    color: white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          child: FavouriteItem(
                            widget: Text(
                              ContactsCubit.get(context)
                                  .contacts[index]
                                  .contact!
                                  .time!,
                              style: GoogleFonts.poppins(
                                  color: customGrey, fontSize: 10.sp),
                            ),
                            name: ContactsCubit.get(context)
                                        .contacts[index]
                                        .userInformation == null
                                ? "مستخدم"
                                : ContactsCubit.get(context)
                                    .contacts[index]
                                    .userInformation!
                                    .user_Name!,
                            gender: 1,
                            onClicked: () {
                              user_on_click(context, index);
                            },
                          )
                        ),
                      separatorBuilder: (context, index) => SizedBox( height: 0.5.h,),

                      itemCount: ContactsCubit.get(context).contacts.length),
                ),
              )),
        ),
      ),
    );
  }

  void user_on_click(BuildContext context, int index) 
  {
    if (ContactsCubit.get(context)
                .contacts[index]
                .userInformation != null ) 
    {
      GetInformationCubit.get(context)
          .getInformationUser(
              userId: ContactsCubit.get(context)
                  .contacts[index]
                  .userInformation!
                  .id!);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailsUserScreen( messageVisibility: true,)
          )
      );
    }

  }
}
