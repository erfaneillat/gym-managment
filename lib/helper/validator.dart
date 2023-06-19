import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/src/widgets/form.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../common/constants/constants.dart';

class Validator {
  static String? phone(String? value) {
    if (value == null) {
      return "validator_cant_be_empty".tr();
    }
    if (!Constants.phoneRegExp.hasMatch(value)) {
      return "failure_invalid_phone_number".tr();
    }
    return null;
  }

  static FormFieldValidator required() {
    return FormBuilderValidators.required(
        errorText: "validator_cant_be_empty".tr());
  }
}
