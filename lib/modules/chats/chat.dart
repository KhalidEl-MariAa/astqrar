import 'package:astarar/modules/chats/cubit/cubit.dart';
import 'package:astarar/modules/chats/cubit/states.dart';
import 'package:astarar/modules/details_user/cubit/cubit.dart';
import 'package:astarar/modules/details_user/details_user.dart';
import 'package:astarar/shared/components/components.dart';
import 'package:astarar/shared/components/favourite_item.dart';
import 'package:astarar/shared/components/loading_gif.dart';
import 'package:astarar/shared/components/logo/normal_logo.dart';
import 'package:astarar/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

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
                fallback: (context) => LoadingGif(),
                condition: ContactsCubit.get(context).getContactsDone,
                builder: (context) => Padding(
                  padding: const EdgeInsetsDirectional.only(top: 20),
                  child: ListView.separated(
                      itemBuilder: (context, index) => Dismissible(
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
                                        .userInformation ==
                                    null
                                ? "مستخدم"
                                : ContactsCubit.get(context)
                                    .contacts[index]
                                    .userInformation!
                                    .user_Name!,
                            gender: 1,
                            onClicked: () {
                              if (ContactsCubit.get(context)
                                          .contacts[index]
                                          .userInformation !=
                                      null &&
                                  ContactsCubit.get(context)
                                          .contacts[index]
                                          .userInformation!
                                          .typeUser ==
                                      1) {
                                GetInformationCubit.get(context)
                                    .getInformationUser(
                                        userId: ContactsCubit.get(context)
                                            .contacts[index]
                                            .userInformation!
                                            .id!);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailsUserScreen(
                                              messageVisibility: true,
                                            )));
                              }
                              if (ContactsCubit.get(context)
                                          .contacts[index]
                                          .userInformation != null 
                                          &&
                                  ContactsCubit.get(context)
                                          .contacts[index]
                                          .userInformation!
                                          .typeUser == 2) 
                              {

                                // var delegateId = ContactsCubit.get(context)
                                //     .contacts[index]
                                //     .userInformation!
                                //     .id!;
                                // var delegateName=ContactsCubit.get(context)
                                //     .contacts[index]
                                //     .userInformation!
                                //     .user_Name!;
                                // ProfileDeleagateCubit.get(context)
                                //     .getProfileDelegate(
                                //         delegateId: delegateId);
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             SpeceficDelegateScreen(
                                //               name: delegateName,
                                //               id: delegateId,
                                //             )));
                              }
                            },
                          )),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 0.5.h,
                          ),
                      itemCount: ContactsCubit.get(context).contacts.length),
                ),
              )),
        ),
      ),
    );
  }
}
