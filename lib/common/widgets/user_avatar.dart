import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manage_gym/common/constants/constants.dart';
import 'package:manage_gym/common/extensions/context.dart';

import '../../helper/image_picker.dart';
import '../gen/assets.gen.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar(
      {super.key,
      this.withPlusIcon = false,
      this.radius,
      this.initial,
      this.editable = false});
  final bool withPlusIcon;
  final double? radius;
  final bool editable;
  final String? initial;
  ImageProvider getImage(FormFieldState<String?> field) {
    if (field.value != null && !(field.value as String).startsWith('http')) {
      return FileImage(File(field.value as String));
    }
    if (initial != null) {
      return NetworkImage(Constants.baseUrl + initial!);
    }
    return Assets.icons.profile.provider();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<String?>(
        enabled: editable,
        builder: (field) {
          return InkWell(
            customBorder: const CircleBorder(),
            onTap: !editable
                ? null
                : () async {
                    final image =
                        await ImagePickerHelper.pickImage(ImageSource.gallery);
                    if (image != null) {
                      field.didChange(image.path);
                    }
                  },
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundImage: getImage(field),
                  radius: radius ?? 25,
                ),
                if (withPlusIcon)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: context.colorScheme.primary,
                      child: Icon(
                        Icons.add,
                        color: context.colorScheme.onPrimary,
                        size: 15,
                      ),
                    ),
                  )
              ],
            ),
          );
        },
        name: 'avatar');
  }
}
