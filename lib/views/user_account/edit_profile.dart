import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tours_booking/constants/app_padding.dart';
import 'package:tours_booking/controllers/profiles_controllers/edit_profile_controller.dart';
import 'package:tours_booking/models/user_profile/profile_model.dart';
import 'package:tours_booking/views/main_page/main_page.dart';
import 'package:tours_booking/widgets/app_button.dart';
import 'package:tours_booking/widgets/app_input_field.dart';

import '../../constants/app_colors.dart';
import '../../constants/dummy_data.dart';
import '../../constants/svg_icons.dart';
import '../../widgets/app_cache_image.dart';
import '../../widgets/app_text.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  final ProfileModel userData;
  const EditProfile({
    super.key,
    required this.userData,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final EditProfileController _controller = Get.put(EditProfileController());
  isDataAvailabe() {
    if (widget.userData.uid != null) {
      _controller.name.text = widget.userData.userName.toString();
      _controller.email.text = widget.userData.email.toString();
      _controller.phone.text = widget.userData.phoneNo.toString();
      _controller.dob.text = widget.userData.dob.toString();
    }
  }

  @override
  void initState() {
    isDataAvailabe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.backgroundcolor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: SvgPicture.string(
              SvgIcons.backArrow,
            ),
          ),
        ),
        title: const AppText(
          text: "Edit Profile",
          fontWeight: FontWeight.w600,
          fontSize: 23,
          textcolor: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: AppPadding.defaultPadding,
          child: GetBuilder<EditProfileController>(
            init: EditProfileController(),
            builder: (_) {
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 125,
                    width: 125,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: GetBuilder<EditProfileController>(
                            init: EditProfileController(),
                            initState: (_) {},
                            builder: (_) {
                              if (_.image != null) {
                                return CircleAvatar(
                                  radius: 60,
                                  backgroundImage: FileImage(
                                    _.image!,
                                  ),
                                );
                              } else {
                                return AppCircularCachedImage(
                                  picRadius: 60,
                                  picUrl: widget.userData.profile ??
                                      DummyData.profilePic,
                                );
                              }
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.10,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(86, 0, 0, 0),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                  offset: Offset(2, 0),
                                ),
                              ],
                            ),
                            child: PopupMenuButton(
                              position: PopupMenuPosition.under,
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    child: TextButton(
                                      onPressed: () {
                                        _.getimage(
                                          ImageSource.gallery,
                                        );
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Choose from gallery",
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xff8E89A9),
                                        ),
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    child: TextButton(
                                      onPressed: () {
                                        _.getimage(
                                          ImageSource.camera,
                                        );
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Camera",
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xff8E89A9),
                                        ),
                                      ),
                                    ),
                                  ),
                                ];
                              },
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SvgPicture.string(SvgIcons.pencil),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  AppInputField(
                    hintText: widget.userData.userName.toString(),
                    controller: _.name,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppInputField(
                    hintText: widget.userData.email.toString(),
                    controller: _.email,
                    keyboardtype: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppInputField(
                    hintText: widget.userData.phoneNo.toString(),
                    controller: _.phone,
                    keyboardtype: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppInputField(
                    controller: _.dob,
                    enabled: false,
                    onTap: () async {
                      await _.selectDate(context);
                    },
                    hintText: _.date ?? widget.userData.dob.toString(),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  AppButton(
                    btnText: "Save",
                    ontap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainPage(
                            currentIndex: 0,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
