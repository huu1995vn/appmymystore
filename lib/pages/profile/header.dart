// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mymystore/app_icons.dart';
import 'package:mymystore/core/api/api.bll.dart';
import 'package:mymystore/core/commons/common_constants.dart';
import 'package:mymystore/core/commons/index.dart';
import 'package:mymystore/core/components/mm_icon_button.dart';
import 'package:mymystore/core/components/mm_part.dart';
import 'package:mymystore/core/providers/app_provider.dart';
import 'package:mymystore/core/services/api_token.service.dart';
import 'package:mymystore/core/services/file.service.dart';
import 'package:mymystore/core/utilities/app_colors.dart';
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
            appProvider.user.avatar(size: CommonConstants.kSizeAvatarLarge),
            Positioned.fill(
              child: Align(
                  widthFactor: CommonConstants.kSizeAvatarSmall,
                  alignment: Alignment.bottomRight,
                  child: MMIconButton(
                      icon: AppIcons.camera_1,
                      color: AppColors.grey.withOpacity(0.8),
                      onTap: uploadImage,
                      size: CommonConstants.kSizeAvatarSmall)),
            ),
          ],
        ),
        MMMarginVertical(),
        Text(appProvider.user.name.toUpperCase(),
            style: CommonConstants.kTextTitleStyle.bold),
        MMMarginVertical(),
        Text(appProvider.user.phone, style: CommonConstants.kTextTitleStyle),
        MMMarginVertical(),
        Container(
          color: const Color(0xFFEEEEEE),
          height: 1,
          padding: const EdgeInsets.symmetric(horizontal: 24),
        )
      ],
    );
  }
}
