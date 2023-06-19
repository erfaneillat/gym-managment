import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:manage_gym/common/extensions/context.dart';

class TitledTextField extends StatelessWidget {
  final String title;
  final String name;
  final String hint;
  final bool enabled;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final ValueChanged<String?>? onChanged;
  final TextInputAction? action;
  final int? minLines;
  final int? maxLines;
  final FormFieldValidator<String>? validator;
  final int? maxLength;
  final bool readOnly;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldSetter<String?>? onSubmitted;
  final String? errorText;
  final Widget? suffix;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  const TitledTextField(
      {Key? key,
      required this.title,
      required this.name,
      required this.hint,
      this.enabled = true,
      this.keyboardType,
      this.focusNode,
      this.errorText,
      this.onChanged,
      this.action,
      this.minLines,
      this.maxLines,
      this.validator,
      this.maxLength,
      this.readOnly = false,
      this.inputFormatters,
      this.initialValue,
      this.onSubmitted,
      this.suffix,
      this.prefixIcon,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: context.textTheme.labelMedium,
        ),
        const SizedBox(
          height: 5,
        ),
        FormBuilderTextField(
          name: name,
          focusNode: focusNode,
          onChanged: onChanged,
          textDirection: TextDirection.rtl,
          initialValue: initialValue,
          minLines: minLines,
          style: context.textTheme.labelMedium,
          controller: controller,
          decoration: InputDecoration(
              hintTextDirection: TextDirection.rtl,
              contentPadding: const EdgeInsets.all(15),
              errorStyle: context.textTheme.labelMedium!
                  .copyWith(color: context.colorScheme.error, fontSize: 12),
              hintText: hint,
              filled: true,
              hintStyle: context.textTheme.bodySmall,
              fillColor: context.colorScheme.background,
              counter: const SizedBox(),
              errorText: errorText,
              suffix: suffix,
              prefixIcon: prefixIcon),
          keyboardType: keyboardType,
          textInputAction: action,
          inputFormatters: inputFormatters,
          maxLines: maxLines,
          validator: validator,
          maxLength: maxLength,
          onSubmitted: onSubmitted,
          readOnly: readOnly,
          enabled: enabled,
        ),
      ],
    );
  }
}
