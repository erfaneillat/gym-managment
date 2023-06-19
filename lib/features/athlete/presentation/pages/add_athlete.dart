import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:manage_gym/common/extensions/context.dart';
import 'package:manage_gym/common/navigation/navigation.dart';
import 'package:manage_gym/common/widgets/loading_widget.dart';
import 'package:manage_gym/common/widgets/titled_date_picker.dart';
import 'package:manage_gym/common/widgets/titled_textfield.dart';
import 'package:manage_gym/common/widgets/user_avatar.dart';
import 'package:manage_gym/features/athlete/domain/entities/athlete.dart';
import 'package:manage_gym/features/athlete/presentation/bloc/add_athlete_state.dart';
import 'package:manage_gym/features/athlete/presentation/bloc/athlete_bloc.dart';
import 'package:manage_gym/features/athlete/presentation/pages/athlete_list_screen.dart';
import 'package:manage_gym/helper/validator.dart';

class AddAthleteScreen extends StatefulWidget {
  const AddAthleteScreen({super.key, this.athleteEntity});
  final AthleteEntity? athleteEntity;
  @override
  State<AddAthleteScreen> createState() => _AddAthleteScreenState();
}

class _AddAthleteScreenState extends State<AddAthleteScreen> {
  bool showInsuranceDateFields = false;
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  void initState() {
    if (widget.athleteEntity != null) {
      showInsuranceDateFields = widget.athleteEntity!.haveInsurance;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const heightWidget = SizedBox(
      height: 12,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            splashRadius: 25,
            onPressed: () {
              NavigationFlow.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: context.colorScheme.onBackground,
            )),
        actions: [
          BlocConsumer<AthleteBloc, AthleteState>(
            listener: (context, state) {
              if (state.addAthleteState is AddAthleteSuccess) {
                NavigationFlow.back(true);
                context.showMessage(
                    (state.addAthleteState as AddAthleteSuccess).isUpdate
                        ? 'updating_athlete_was_successful'.tr()
                        : 'adding_athlete_was_successful'.tr(),
                    SnackBarType.success);

                athleteListKey.currentState!.refresh();
              }
              if (state.addAthleteState is AddAthleteFailure) {
                context.showMessage(
                    (state.addAthleteState as AddAthleteFailure).message,
                    SnackBarType.error);
              }
            },
            buildWhen: (previous, current) {
              return previous.addAthleteState != current.addAthleteState;
            },
            listenWhen: (previous, current) {
              return previous.addAthleteState != current.addAthleteState;
            },
            builder: (context, state) {
              if (state.addAthleteState is AddAthleteLoading) {
                return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: LoadingWidget());
              }
              return IconButton(
                  splashRadius: 25,
                  onPressed: () {
                    if (_formKey.currentState!.saveAndValidate()) {
                      final values = _formKey.currentState!.value;

                      context.read<AthleteBloc>().add(AddAthleteEvent(
                            athleteEntity: AthleteEntity(
                              id: widget.athleteEntity?.id ?? '',
                              nameAndFamily: values['name_and_family'],
                              phoneNumber: values['phone_number'],
                              profileImage: values['avatar'],
                              nationalCode: values['national_code'],
                              fatherName: values['father_name'],
                              description: values['description'],
                              lastPayment: values['last_payed_gym_fee'],
                              registerInGymDate: values['register_date_in_gym'],
                              haveInsurance: values['athlete_has_insurance'],
                              registeredEveryOtherDay:
                                  values['registered_every_other_day'],
                              insuranceStart: values['start_date'],
                              insuranceEnd: values['end_date'],
                            ),
                            isUpdate: widget.athleteEntity != null,
                          ));
                    }
                  },
                  icon: Icon(
                    Icons.check,
                    color: context.colorScheme.primary,
                  ));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'add_athlete_form'.tr(),
                  style: context.textTheme.labelLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                UserAvatar(
                  radius: 50,
                  editable: true,
                  withPlusIcon: true,
                  initial: widget.athleteEntity?.profileImage,
                ),
                heightWidget,
                TitledTextField(
                    initialValue: widget.athleteEntity?.nameAndFamily,
                    title: 'name_and_family'.tr(),
                    name: 'name_and_family',
                    validator: Validator.required(),
                    hint: ''),
                heightWidget,
                TitledTextField(
                    initialValue: widget.athleteEntity?.phoneNumber,
                    title: 'phone_number'.tr(),
                    name: 'phone_number',
                    keyboardType: TextInputType.phone,
                    validator: Validator.phone,
                    hint: ''),
                heightWidget,
                TitledTextField(
                    initialValue: widget.athleteEntity?.nationalCode,
                    title: 'national_code'.tr(),
                    name: 'national_code',
                    keyboardType: TextInputType.number,
                    validator: Validator.required(),
                    hint: ''),
                heightWidget,
                TitledTextField(
                    initialValue: widget.athleteEntity?.fatherName,
                    title: 'father_name'.tr(),
                    name: 'father_name',
                    validator: Validator.required(),
                    hint: ''),
                heightWidget,
                TitledTextField(
                    initialValue: widget.athleteEntity?.description,
                    title: 'description'.tr(),
                    name: 'description',
                    hint: ''),
                TitledDatePickerWidget(
                    initialDate: widget.athleteEntity?.lastPayment,
                    onChange: (d) {},
                    title: 'last_payed_gym_fee'.tr(),
                    name: 'last_payed_gym_fee'),
                TitledDatePickerWidget(
                    initialDate: widget.athleteEntity?.registerInGymDate,
                    onChange: (d) {},
                    title: 'register_date_in_gym'.tr(),
                    name: 'register_date_in_gym'),
                FormBuilderCheckbox(
                    name: 'athlete_has_insurance',
                    initialValue: showInsuranceDateFields,
                    onChanged: (value) {
                      if (!value!) {
                        _formKey.currentState?.fields['start_date']?.reset();
                        _formKey.currentState?.fields['end_date']?.reset();
                      }
                      setState(() {
                        showInsuranceDateFields = value;
                      });
                    },
                    title: Text(
                      'athlete_has_insurance'.tr(),
                      style: context.textTheme.labelMedium,
                    )),
                if (showInsuranceDateFields) ...[
                  TitledDatePickerWidget(
                      initialDate: widget.athleteEntity?.insuranceStart,
                      onChange: (d) {},
                      title: 'start_date'.tr(),
                      name: 'start_date'),
                  TitledDatePickerWidget(
                      initialDate: widget.athleteEntity?.insuranceEnd,
                      onChange: (d) {},
                      title: 'end_date'.tr(),
                      name: 'end_date'),
                ],
                FormBuilderCheckbox(
                    name: 'registered_every_other_day',
                    initialValue:
                        widget.athleteEntity?.registeredEveryOtherDay ?? false,
                    onChanged: (value) {},
                    title: Text(
                      'registered_every_other_day'.tr(),
                      style: context.textTheme.labelMedium,
                    )),
              ],
            ),
          )),
    );
  }
}
