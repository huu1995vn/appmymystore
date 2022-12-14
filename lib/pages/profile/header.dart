// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mymystore/core/api/api.bll.dart';
import 'package:mymystore/core/commons/common_constants.dart';
import 'package:mymystore/core/commons/index.dart';
import 'package:mymystore/core/components/mm_part.dart';
import 'package:mymystore/core/providers/app_provider.dart';
import 'package:mymystore/core/services/api_token.service.dart';
import 'package:mymystore/core/services/auth.service.dart';
import 'package:mymystore/core/services/file.service.dart';
import 'package:mymystore/core/utilities/extensions.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  uploadImage() async {
    try {
      var path = await FileService.getImagePicker(context);
      if (path.isNullEmpty) {
        CommonMethods.showToast(CommonConstants.MESSAGE_ERROR_EMPTY);
        return;
      }
      var url = await FileService.uploadImageByPath(path);
      if (url.isNullEmpty) {
        return;
      }
       var res = await ApiBLL_APIUser().updateavatar(url);
        if (res.status > 0) {
          var res = await ApiBLL_APIToken().refreshlogin(APITokenService.token);
          if (res.status > 0) {
            APITokenService.token = res.data;
            Provider.of<AppProvider>(context).user = APITokenService.user;
          }
        } else {
          CommonMethods.showToast(res.message);
        }
    } catch (e) {
      CommonMethods.showToast(CommonConstants.MESSAGE_ERROR);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context, listen: true);

    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: MMImageProvider(appProvider.user.mmimage),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  child: Image.asset('assets/icons/profile/edit_square@2x.png',
                      scale: 2),
                  onTap: () {
                    uploadImage();
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(appProvider.user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        const SizedBox(height: 8),
        Text(appProvider.user.phone,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 20),
        Container(
          color: const Color(0xFFEEEEEE),
          height: 1,
          padding: const EdgeInsets.symmetric(horizontal: 24),
        )
      ],
    );
  }
}
