import 'package:flutter/material.dart';
import 'package:manage_gym/common/extensions/context.dart';
import 'package:manage_gym/features/athlete/domain/entities/short_athlete_data.dart';

import '../../../../common/widgets/user_avatar.dart';

class AthleteItem extends StatelessWidget {
  const AthleteItem({super.key, required this.onTap, required this.athlete});
  final void Function() onTap;
  final ShortAthleteDataEntity athlete;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          customBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onTap: onTap,
          child: Ink(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: context.colorScheme.secondaryContainer,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 2)
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                UserAvatar(
                  initial: athlete.profileImage,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      athlete.nameAndFamily,
                      style:
                          context.textTheme.labelMedium!.copyWith(fontSize: 16),
                    ),
                    Text(
                      athlete.untilPayment < 0
                          ? '${athlete.untilPayment.abs()} روز تاخیر در پرداخت شهریه'
                          : '${athlete.untilPayment} روز مانده تا پرداخت شهریه',
                      style: context.textTheme.labelSmall!.copyWith(
                          color: athlete.untilPayment < 0
                              ? Colors.red
                              : Colors.green[600]),
                    ),
                    Text(
                      athlete.description != null ||
                              athlete.description!.isNotEmpty
                          ? athlete.description!
                          : 'بدون توضیحات',
                      style: context.textTheme.labelSmall!
                          .copyWith(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
