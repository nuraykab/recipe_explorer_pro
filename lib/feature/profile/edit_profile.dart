import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/constants/images.dart';
import '../../utils/theme/theme_container.dart';
import '../../utils/validators/validator.dart';
import '../../utils/widget/button.dart';
import '../../utils/widget/textfield.dart';
import '../auth/widget/intro_appbar.dart';
import 'widget/avatar_sheet.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return PopScope(
      onPopInvokedWithResult: (_, result) {
        userProvider.profileText = userProvider.user.profile;
        userProvider.fullNameText.text = userProvider.user.name;
        userProvider.phoneNumberText.text = userProvider.user.number;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const IntroAppbar(titleText: 'Edit Profile'),
        body: ThemeContainer(
          child: SingleChildScrollView(
            child: KeyboardDismissOnTap(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: height * 0.15,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: width * 0.21,
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        backgroundImage: userProvider.user.profile.isNotEmpty
                            ? AssetImage(userProvider.profileText)
                                as ImageProvider
                            : AssetImage(Images.avatar) as ImageProvider,
                        onBackgroundImageError: (error, stackTrace) {
                          Image.asset(
                            Images.avatar,
                            fit: BoxFit.cover,
                            height: height * 0.25,
                          );
                        },
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                            builder: (BuildContext context) {
                              return SizedBox(
                                height: height * 0.85,
                                child: const AvatarSheet(),
                              );
                            },
                          ),
                          child: CircleAvatar(
                            radius: width * 0.06,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: width * 0.06,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                  MyTextField(
                    hintText: "Full Name",
                    validator: (value) =>
                        InputValidators.validateEmpty("Name", value),
                    controller: userProvider.fullNameText,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                  ),
                  MyTextField(
                    hintText: 'Phone Number',
                    controller: userProvider.phoneNumberText,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    validator: (value) =>
                        InputValidators.validatePhoneNumber(value),
                  ),
                  SizedBox(height: height * 0.02),
                  Button().mainButton('Save', context, () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    userProvider.updateUser().whenComplete(() {
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    });
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
