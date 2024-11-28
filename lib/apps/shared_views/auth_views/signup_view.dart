import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_assist/apps/shared_views/auth_views/email_verification.dart';
import 'package:pharmacy_assist/main_barrel.dart';
import 'package:sizer/sizer.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final pharmacyNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();

  String? businessTypes;
  Uint8List? profileImage;
  Uint8List? licenseImageBytes;
  FocusNode focusNode = FocusNode();
  String initialCountry = 'US';

  Map<String, bool> validateSignupDetails() {
    return {
      'pharmacyName': pharmacyNameController.text.isNotEmpty,
      'email': emailController.text.isNotEmpty,
      'phone': phoneController.text.isNotEmpty,
      'address': addressController.text.isNotEmpty,
      'password': passwordController.text.isNotEmpty,
      'businessType': businessTypes != null,
      'imageBytes': profileImage != null,
      'licenseImageBytes': licenseImageBytes != null,
    };
  }

  void onSubmit(BuildContext context, Map<String, dynamic> formData) {
    final validationResults = validateSignupDetails();
    bool allValid = validationResults.values.every((isValid) => isValid);
    if (allValid) {
      context.read<AuthCubit>().signUp(formData, () {
        push(context, EmailVerificationView(email: emailController.text));
      }, () {
        alert(
            info: true,
            context,
            context.read<AuthCubit>().repo.errorModel.error);
      });
    } else {
      bool allEmpty = validationResults.values.every((isValid) => !isValid);
      if (allEmpty) {
        alert(info: false, context, allFieldsRequired.tr());
      } else {
        alert(info: false, context, allFieldsRequired.tr());
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    pharmacyNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundComponent(
          showBackButton: true,
          imagePath: Assets.pharmacyBoard,
          gradientColors: const [
            Palette.signUpGradiant1,
            Palette.signUpGradiant2
          ],
          containerFlex1: 1,
          containerFlex2: 1,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  signUp.tr(),
                  style: CustomFontStyle.boldText
                      .copyWith(fontSize: 30, color: Palette.primary),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      ImagePickerWidget(
                          image: profileImage,
                          onImageSelected: (Uint8List? image) {
                            setState(() {
                              profileImage = image;
                            });
                          },
                          assetPath: Assets.dummyParmacy),
                      SizedBox(height: 2.h),
                      Text(
                        uploadProfile.tr(),
                        style: CustomFontStyle.regularText
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                TextFieldComponent(
                  controller: pharmacyNameController,
                  infoLabel: pharmacyName.tr(),
                  hideShadow: true,
                  hideBorder: true,
                  backgroundColor: Colors.white,
                  prefixIconPath: Assets.pillsIcon,
                  hintText: name.tr(),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 2.h,
                ),
                TextFieldComponent(
                  controller: emailController,
                  hideShadow: true,
                  hideBorder: true,
                  infoLabel: email.tr(),
                  backgroundColor: Colors.white,
                  prefixIconPath: Assets.emailIcon,
                  hintText: someoneGmail.tr(),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 2.h,
                ),
                CountryPickerWidget(
                  onPhoneNumberChanged: (phoneNumber) {
                    setState(() {
                      phoneController.text = phoneNumber.replaceAll(' ', '');
                    });
                  },
                ),
                SizedBox(
                  height: 2.h,
                ),
                TextFieldComponent(
                  controller: addressController,
                  hideShadow: true,
                  hideBorder: true,
                  infoLabel: address.tr(),
                  backgroundColor: Colors.white,
                  prefixIconPath: Assets.locationIcon,
                  hintText: address.tr(),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 2.h,
                ),
                TextFieldComponent(
                  controller: passwordController,
                  hideShadow: true,
                  hideBorder: true,
                  infoLabel: password.tr(),
                  backgroundColor: Colors.white,
                  prefixIconPath: Assets.keyIcon,
                  hintText: password.tr(),
                  obscureText: true,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 2.h,
                ),
                DropdownComponent(
                    items: [pharmacy.tr(), drugDepot.tr()],
                    value: businessTypes,
                    title: businessType.tr(),
                    labelBuilder: (label) => label,
                    onChanged: (value) {
                      setState(() {
                        businessTypes = value;
                      });
                    }),
                SizedBox(
                  height: 3.h,
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () async {
                      final image = await pickImageWeb();
                      if (image != null) {
                        if (context.mounted) {
                          setState(() {
                            licenseImageBytes = image;
                          });
                        }
                      }
                    },
                    child: Container(
                      height: 189,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Palette.lightGrey,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          licenseImageBytes != null
                              ? Image.memory(
                                  licenseImageBytes!,
                                  height: 100,
                                )
                              : Image.asset(
                                  Assets.imageUpload,
                                  height: 63,
                                ),
                          SizedBox(
                            height: 1.h,
                          ),
                          licenseImageBytes != null
                              ? const SizedBox.shrink()
                              : Text(
                                  uploadALicense.tr(),
                                  style: CustomFontStyle.regularText
                                      .copyWith(fontSize: 20),
                                )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return ButtonComponent(
                      isLoading: state is AuthLoading,
                      text: next.tr(),
                      onPressed: () async {
                        File? profilePictureFile;
                        File? certificateFile;
                        if (profileImage != null) {
                          profilePictureFile = await convertUint8ListToFile(
                              profileImage!, 'profile_picture.png');
                        }

                        if (licenseImageBytes != null) {
                          certificateFile = await convertUint8ListToFile(
                              licenseImageBytes!, 'license.png');
                        }
                        Map<String, dynamic> formData = {
                          'role': businessType == pharmacy.tr()
                              ? 'pharmacy'
                              : 'drugDepot',
                          'address': addressController.text,
                          'certificate': certificateFile,
                          'profilePicture': profilePictureFile,
                          'phoneNumber': phoneController.text,
                          'countryCode': countryCode,
                          'password': passwordController.text,
                          'email': emailController.text,
                          'name': pharmacyNameController.text,
                        };
                        log('map: ${formData.toString()}');
                        if (context.mounted) {
                          onSubmit(context, formData);
                        }
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 3.h,
                ),
              ],
            ),
          )),
    );
  }
}
