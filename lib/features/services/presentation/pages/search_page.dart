import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:servit_project_version_2/core/app/app_style.dart';
import 'package:servit_project_version_2/injection.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          header(),
        ],
      ),
    );
  }

  Container header() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: const BoxDecoration(
        color: FlexColor.sakuraLightPrimary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(23),
          bottomRight: Radius.circular(23),
        ),
      ),
      child: Column(
        children: [
          Material(
            color: transaparentColor,
            child: const Row(
              children: [
                BackButton(
                  color: Colors.white,
                  style: ButtonStyle(
                    iconSize: MaterialStatePropertyAll(30),
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.zero,
                    ),
                    visualDensity: VisualDensity.compact,
                  ),
                ),
                Gap(16),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      prefixIcon: Icon(
                        Icons.search,
                        size: 26,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
