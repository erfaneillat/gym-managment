import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:manage_gym/common/extensions/context.dart';
import 'package:manage_gym/common/navigation/navigation.dart';
import 'package:manage_gym/common/widgets/loading_widget.dart';
import 'package:manage_gym/common/widgets/max_width.dart';
import 'package:manage_gym/helper/validator.dart';
import 'package:manage_gym/params/input_params.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/widgets/titled_textfield.dart';
import '../../../../locator.dart';
import '../../domain/entities/gym_entity.dart';
import '../blocs/sign_up_bloc/sign_up_gym_bloc.dart';

class SignUpGymScreen extends StatefulWidget {
  const SignUpGymScreen({super.key, this.gymEntity});
  final GymEntity? gymEntity;

  @override
  State<SignUpGymScreen> createState() => _SignUpGymScreenState();
}

class _SignUpGymScreenState extends State<SignUpGymScreen> {
  ScrollController? _scrollController;
  bool lastStatus = true;
  double expandedHeight = 150;
  final signUpKey = GlobalKey<FormBuilderState>();
  void _scrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  bool get _isShrink {
    return _scrollController != null &&
        _scrollController!.hasClients &&
        _scrollController!.offset > (expandedHeight - kToolbarHeight);
  }

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  void onConfirm() {
    if (signUpKey.currentState!.saveAndValidate()) {
      final data = signUpKey.currentState!.value;

      context.read<SignUpGymBloc>().add(SignUpGymEvent(
          params: SignUpInputParams(
            gymFee: double.parse(data['gym_fee_rate']),
            gymName: data['gym_name'],
            nameAndFamily: data['name_family'],
          ),
          isUpdate: widget.gymEntity != null));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      body: SafeArea(
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                leading: const SizedBox(),
                backgroundColor: context.colorScheme.primary,
                expandedHeight: expandedHeight,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: _isShrink
                      ? Text(
                          'sign_up_gym'.tr(),
                          style: context.textTheme.labelLarge!.copyWith(
                              fontSize: 16,
                              color: context.colorScheme.onPrimary),
                        )
                      : null,
                  background: Center(
                    child: Text('sign_up_gym'.tr(),
                        style: context.textTheme.labelLarge!.copyWith(
                            fontSize: 22,
                            color: context.colorScheme.onPrimary)),
                  ),
                ),
              ),
            ];
          },
          body: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: context.colorScheme.background,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: FormBuilder(
                  key: signUpKey,
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            TitledTextField(
                                initialValue: widget.gymEntity?.nameAndFamily,
                                title: 'name_and_family'.tr(),
                                validator: Validator.required(),
                                action: TextInputAction.next,
                                maxLines: 1,
                                name: 'name_family',
                                hint: ''),
                            TitledTextField(
                                initialValue: widget.gymEntity?.gymName,
                                title: 'gym_name'.tr(),
                                validator: Validator.required(),
                                action: TextInputAction.next,
                                maxLines: 1,
                                name: 'gym_name',
                                hint: ''),
                            TitledTextField(
                                title: 'gym_fee_rate'.tr(),
                                initialValue:
                                    widget.gymEntity?.gymFee.toString(),
                                validator: Validator.required(),
                                action: TextInputAction.done,
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                name: 'gym_fee_rate',
                                hint: ''),
                            if (widget.gymEntity != null)
                              TitledTextField(
                                  initialValue: widget.gymEntity?.phoneNumber,
                                  title: 'phone_number'.tr(),
                                  enabled: false,
                                  validator: Validator.required(),
                                  action: TextInputAction.next,
                                  maxLines: 1,
                                  name: 'phone_number',
                                  hint: ''),
                            const SizedBox(
                              height: 20,
                            ),
                            BlocConsumer<SignUpGymBloc, SignUpGymState>(
                              listener: (context, state) async {
                                if (state is SignUpGymSuccess) {
                                  if (widget.gymEntity != null) {
                                    NavigationFlow.back(true);
                                    return;
                                  }
                                  await sl<SharedPreferences>.call()
                                      .setInt('loginStep', 2);

                                  NavigationFlow.toHome();
                                }
                              },
                              builder: (context, state) {
                                if (state is SignUpGymLoading) {
                                  return const LoadingWidget();
                                }
                                return MaxWidthWidget(
                                  child: ElevatedButton(
                                      onPressed: onConfirm,
                                      child: Text(
                                        'confirm'.tr(),
                                        style: context.textTheme.labelMedium!
                                            .copyWith(
                                                color: context
                                                    .colorScheme.onPrimary),
                                      )),
                                );
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ))),
        ),
      ),
    );
  }
}
