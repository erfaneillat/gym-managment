import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:manage_gym/common/extensions/context.dart';
import 'package:manage_gym/helper/validator.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class TitledDatePickerWidget extends StatefulWidget {
  const TitledDatePickerWidget(
      {super.key,
      required this.onChange,
      required this.title,
      this.initialDate,
      required this.name});
  final void Function(DateTime? date) onChange;
  final String title;
  final String name;
  final DateTime? initialDate;
  @override
  State<TitledDatePickerWidget> createState() => _TitledDatePickerWidgetState();
}

class _TitledDatePickerWidgetState extends State<TitledDatePickerWidget> {
  @override
  void initState() {
    if (widget.initialDate != null) {
      selectedDate = widget.initialDate;
      jaliliSelectedDate = Jalali.fromDateTime(widget.initialDate!);
    }
    super.initState();
  }

  DateTime? selectedDate;
  Jalali? jaliliSelectedDate;
  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
        name: widget.name,
        initialValue: selectedDate,
        validator: Validator.required(),
        builder: (FormFieldState<dynamic> field) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: context.textTheme.labelMedium!.copyWith(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: context.colorScheme.secondaryContainer),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          selectedDate == null
                              ? ''
                              : '${jaliliSelectedDate!.year}/${jaliliSelectedDate!.month}/${jaliliSelectedDate!.day}',
                          style: context.textTheme.labelMedium!
                              .copyWith(fontSize: 14),
                        ),
                      ),
                      IconButton(
                          splashRadius: 20,
                          onPressed: () async {
                            jaliliSelectedDate = await showPersianDatePicker(
                              context: context,
                              initialDate: Jalali.now(),
                              firstDate: Jalali(1385, 8),
                              lastDate: Jalali(1450, 9),
                            );
                            selectedDate = jaliliSelectedDate?.toDateTime();

                            widget.onChange(selectedDate);
                            field.didChange(selectedDate);
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.date_range,
                            color: context.colorScheme.primary,
                          ))
                    ],
                  ),
                ),
                if (field.errorText != null) ...[
                  const SizedBox(
                    height: 5,
                  ),
                  Text(field.errorText ?? '',
                      style: context.textTheme.labelMedium!
                          .copyWith(color: Colors.red, fontSize: 12)),
                ]
              ],
            ),
          );
        });
  }
}
