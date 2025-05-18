import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class AvatarSheet extends StatelessWidget {
  const AvatarSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    // final user = Get.put(UserController());

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.builder(
        itemCount: userProvider.avatarList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              userProvider.changeProfile(index);
              Navigator.pop(context);
              // userProvider.updateUserImage();
            },
            child: Image.asset(userProvider.avatarList[index]),
          );
        },
      ),
    );
  }
}
