import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:np_com_pandeykushal/view/components/custom_appbar.dart';
import 'package:np_com_pandeykushal/view/components/custom_bottoast.dart';
import 'package:np_com_pandeykushal/view/export_view.dart';
import 'package:np_com_pandeykushal/view/screens/ShowDetails.dart';
import 'package:np_com_pandeykushal/view/screens/splash_screen.dart';
import 'package:np_com_pandeykushal/view_model/export_view_model.dart';
import 'package:provider/provider.dart';

import '../../view_model/providers/export_provider.dart';
import 'travel.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  static const String routeName = "/basepage";
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const BasePage());
  }

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<DatePickerProvider>(
        builder: (context, homeProvider, child) {
      return SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(title: 'kushal  App', onBackTap: () {}),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                        text: "Travel",
                        onTap: () async {
                          await homeProvider.fetchTravels();
                          context.push(Travel.routeName);
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                        text: "TravelDetails",
                        onTap: () async {
                          await homeProvider.fetchTravelDetails();
                          context.push(TravelDetail.routeName);
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    Text("/travel/travel-details/"),
                    SizedBox(
                      height: 20,
                    ),
                    textField(
                      'travel.name',
                      TextInputType.emailAddress,
                      TextInputAction.done,
                      showEnabledBorder: true,
                      controller: homeProvider.travelname,
                      label: "travel.name",
                      showLabel: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    textField(
                      'travel_agenda',
                      TextInputType.emailAddress,
                      TextInputAction.done,
                      showEnabledBorder: true,
                      controller: homeProvider.travelAgenda,
                      label: "travel_agenda",
                      showLabel: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    textField(
                      'travel.description',
                      TextInputType.emailAddress,
                      TextInputAction.done,
                      showEnabledBorder: true,
                      controller: homeProvider.description,
                      label: "travel.description",
                      showLabel: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: selectImageProfile(
                            fileDescription: "Profile  Picture",
                            fileType: AppConstant.profilePic1,
                            regProv: homeProvider,
                            selectedFile: homeProvider.profilePic)),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                        text: "/travel/travel-details/",
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            FormData registerForm = FormData.fromMap({
                              "travel.name": homeProvider.travelname.text,
                              "travel_agenda": homeProvider.travelAgenda.text,
                              "travel.description":
                                  homeProvider.description.text,
                              "group_photo": homeProvider.profilePic == null
                                  ? null
                                  : await MultipartFile.fromFile(
                                      homeProvider.profilePic!.path,
                                    ),
                            });

                            homeProvider
                                .posttravelDetails(
                              datas: registerForm,
                            )
                                .then((isLoggedIn) async {
                              homeProvider.clerEverything();
                              // await homeProvider.travelDetails();
                              context.pop();
                            });

                            // setState(() {
                            //   forgotPasswordEmail = forgotEmailController.text;
                            // });
                            // context.push(VerificationOtp.routeName,
                            //     extra: forgotPasswordEmail);
                          }
                        }),
                    SizedBox(
                      height: 50,
                    ),
                    Text('/travel/travel/'),
                    textField(
                      'traveldetails_set[0]travel_agenda',
                      TextInputType.emailAddress,
                      TextInputAction.done,
                      showEnabledBorder: true,
                      controller: homeProvider.traveldetailsagenda,
                      label: "traveldetails_set[0]travel_agenda",
                      showLabel: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    textField(
                      'name ',
                      TextInputType.emailAddress,
                      TextInputAction.done,
                      showEnabledBorder: true,
                      controller: homeProvider.name,
                      label: "name ",
                      showLabel: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    textField(
                      'description',
                      TextInputType.emailAddress,
                      TextInputAction.done,
                      showEnabledBorder: true,
                      controller: homeProvider.traveldetaildescription,
                      label: "description",
                      showLabel: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: selectImageProfile(
                            fileDescription: "Profile  Picture",
                            fileType: AppConstant.profilePic1,
                            regProv: homeProvider,
                            selectedFile: homeProvider.profilePic)),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                        text: "/travel/travel-details/",
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            FormData registerForm = FormData.fromMap({
                              "traveldetails_set[0]travel_agenda":
                                  homeProvider.traveldetailsagenda.text,
                              "name": homeProvider.name.text,
                              "description":
                                  homeProvider.traveldetaildescription.text,
                              "traveldetails_set[0]group_photo":
                                  homeProvider.profilePic == null
                                      ? null
                                      : await MultipartFile.fromFile(
                                          homeProvider.profilePic!.path,
                                        ),
                            });

                            homeProvider
                                .posttravetravel(
                              datas: registerForm,
                            )
                                .then((isLoggedIn) async {
                              homeProvider.clerEverything();
                              // await homeProvider.travelDetails();
                              context.pop();
                            });

                            // setState(() {
                            //   forgotPasswordEmail = forgotEmailController.text;
                            // });
                            // context.push(VerificationOtp.routeName,
                            //     extra: forgotPasswordEmail);
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget selectImageProfile({
    required String fileDescription,
    required String fileType,
    required DatePickerProvider regProv,
    required File? selectedFile,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () async {
                await regProv.prefileProfile == null;

                await regProv
                    .pickFiles(
                  fileType: fileType,
                )
                    .then(
                  (value) {
                    regProv.prefileProfile == null;
                  },
                );
                print(selectedFile);
              },
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  if (selectedFile?.path != null) ...[
                    Center(
                      child: ClipOval(
                        child: Image.file(
                          File(selectedFile!.path),
                          height: 100,
                          width: 250,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return ClipOval(
                              child: Image.asset(
                                AppConstant.userPlaceholderImage,
                                height: 100,
                                width: 250,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ] else ...[
                    regProv.prefileProfile != null
                        ? Center(
                            child: ClipOval(
                              child: Image.network(
                                regProv.prefileProfile ?? '',
                                height: 100.h,
                                width: 100.w,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.network(
                                    AppConstant.userPlaceholderImage,
                                    height: 100,
                                    width: 250,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          )
                        : Center(
                            child: Image.network(
                              AppConstant.userPlaceholderImage,
                              height: 100.h,
                              width: 250.w,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return ClipOval(
                                  child: Image.asset(
                                    CustomImageGetter.logo,
                                    // AppConstant.userPlaceholderImage,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                          ),
                  ],
                  Container(
                    margin: const EdgeInsets.only(bottom: 3.0),
                    decoration: BoxDecoration(
                      color: AppColor.primary1.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 60,
                    width: 80,
                    child: Icon(
                      Icons.camera_alt,
                      size: 20,
                      color: AppColor.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
