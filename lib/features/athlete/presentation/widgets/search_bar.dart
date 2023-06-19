import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manage_gym/common/extensions/context.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key, required this.onSearch});
  final Function(String)? onSearch;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          decoration: BoxDecoration(
              color: context.colorScheme.secondaryContainer,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 2)
              ],
              borderRadius: BorderRadius.circular(100)),
          padding: const EdgeInsets.all(0),
          width: double.infinity,
          child: TextField(
            style: context.textTheme.labelMedium,
            onChanged: onSearch,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: context.textTheme.bodySmall,
                hintText: '${'search'.tr()} ...',
                contentPadding: const EdgeInsets.symmetric(horizontal: 10)),
          ),
        ),
        Positioned(
          left: 0,
          top: 2,
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () {},
              child: Ink(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colorScheme.primary,
                    boxShadow: [
                      BoxShadow(
                        color: context.colorScheme.shadow,
                        spreadRadius: 3,
                        blurRadius: 3,
                      )
                    ]),
                child: Icon(
                  Icons.search,
                  color: context.colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
