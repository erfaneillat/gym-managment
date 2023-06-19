import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:manage_gym/common/extensions/context.dart';
import 'package:manage_gym/common/widgets/max_width.dart';
import 'package:manage_gym/common/widgets/titled_textfield.dart';
import 'package:manage_gym/helper/validator.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../common/navigation/navigation.dart';
import '../../../../common/widgets/titled_date_picker.dart';

class EditInsuranceDialog extends StatelessWidget {
  EditInsuranceDialog({
    super.key,
  });
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: FormBuilder(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  centerTitle: true,
                  title: Text(
                    'edit_insurance'.tr(),
                    style: context.textTheme.labelMedium,
                  ),
                  leading: IconButton(
                      splashRadius: 20,
                      onPressed: () {
                        NavigationFlow.back();
                      },
                      icon: Icon(
                        Icons.close,
                        color: context.colorScheme.onBackground,
                      )),
                ),
                TitledDatePickerWidget(
                  title: 'start_date'.tr(),
                  onChange: (d) {},
                  name: 'start_date',
                ),
                TitledDatePickerWidget(
                  title: 'end_date'.tr(),
                  onChange: (d) {},
                  name: 'end_date',
                ),
                TitledTextField(
                  validator: Validator.required(),
                  title: 'insurance_number'.tr(),
                  name: 'insurance_number',
                  hint: 'insurance_number'.tr(),
                ),
                const SizedBox(
                  height: 10,
                ),
                MaxWidthWidget(
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.saveAndValidate()) {
                          print(_formKey.currentState!.value);
                        }
                      },
                      child: Text(
                        'submit'.tr(),
                        style: context.textTheme.labelMedium!
                            .copyWith(color: context.colorScheme.onPrimary),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                MaxWidthWidget(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.colorScheme.error,
                      ),
                      onPressed: () {},
                      child: Text(
                        'delete_insurance'.tr(),
                        style: context.textTheme.labelMedium!
                            .copyWith(color: context.colorScheme.onPrimary),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
