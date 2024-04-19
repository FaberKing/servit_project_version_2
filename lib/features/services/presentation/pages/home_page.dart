import 'dart:developer';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:servit_project_version_2/core/app/app_style.dart';
import 'package:servit_project_version_2/core/app/bloc/app_bloc.dart';
import 'package:servit_project_version_2/features/services/presentation/bloc/all_category/all_category_bloc.dart';
import 'package:servit_project_version_2/features/services/presentation/bloc/all_services/all_services_bloc.dart';
import 'package:servit_project_version_2/features/services/presentation/widget/bottom_loader.dart';
import 'package:servit_project_version_2/features/services/presentation/widget/services_item.dart';
import 'package:servit_project_version_2/features/services/presentation/widget/network_image_get.dart';
import 'package:servit_project_version_2/features/services/presentation/widget/service_category_item.dart';
import 'package:servit_project_version_2/injection.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.ee});
  final String ee;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    refresh();
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async => refresh(),
      child: ListView(
        children: [
          header(),
          event(),
          category(),
          BlocProvider(
            create: (context) => locator<AllServicesBloc>()..add(OnGetAllServices()),
            child: allServices(),
          ),
        ],
      ),
    );
  }

  Container allServices() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All Services',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
              ),
              IconButton.filled(
                visualDensity: VisualDensity.compact,
                iconSize: 26,
                onPressed: () {},
                icon: const Icon(Icons.chevron_right_outlined),
                padding: const EdgeInsets.all(0),
              ),
            ],
          ),
          const Gap(16),
          BlocBuilder<AllServicesBloc, AllServicesStatePro>(
            builder: (context, state) {
              switch (state.status) {
                case ServicesStatus.failure:
                  return Center(
                    child: Text(state.message),
                  );
                case ServicesStatus.success:
                  if (state.services.isEmpty) {
                    return const Center(
                      child: Text('No services'),
                    );
                  }
                  return ListView.builder(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        state.hasReachedMax ? state.services.length : state.services.length + 1,
                    itemBuilder: (context, index) {
                      if (index >= state.services.length) {
                        log("$state -------------------- home - 1");
                        return const BottomLoader();
                      } else {
                        log("$state --------------------- home - 2");

                        final service = state.services[index];
                        return ServicesItem(data: service);
                      }
                      // return index >= state.services.length
                      //     ? const BottomLoader()
                      //     : ServicesItem(data: service);
                    },
                  );
                case ServicesStatus.initial:
                  log("$state --------------------- home - 3");

                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
              }
            },
          ),
        ],
      ),
    );
  }

  Container category() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Category",
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
          ),
          const Gap(16),
          Center(
            child: BlocBuilder<AllCategoryBloc, AllCategoryState>(
              builder: (context, state) {
                if (state is AllCategoryFailure) {
                  return Text(state.message);
                }
                if (state is AllCategoryLoaded) {
                  List<Map<String, dynamic>> categories = state.data;
                  return Wrap(
                    spacing: 26,
                    runSpacing: 8,
                    children: List.generate(categories.length, (index) {
                      final category = state.data[index];
                      return ServiceCategoryItem(title: category["name"]);
                    }),
                    // children: List.generate(
                    //   6,
                    //   (index) => const ServiceCategoryItem(
                    //     iconCategory: Icons.abc,
                    //     title: "udah ee?",
                    //   ),
                    // ),
                  );
                }
                return const SizedBox(
                  height: 30,
                  child: Text("nothing"),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Column event() {
    final pageController = PageController();
    List<String> dumbList = ["ee1", "ee2", "ee3", "ee4", "e5"];

    return Column(
      children: [
        AspectRatio(
          aspectRatio: 2,
          child: PageView.builder(
            controller: pageController,
            itemCount: dumbList.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final dumb = dumbList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: const NetworkImageGet(),
                ),
              );
            },
          ),
        ),
        const Gap(12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SmoothPageIndicator(
              controller: pageController,
              count: dumbList.length,
              effect: WormEffect(
                dotColor: Colors.grey[300]!,
                activeDotColor: FlexColor.sakuraLightPrimary,
                dotWidth: 10,
                dotHeight: 10,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Container header() {
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                children: [
                  Text(
                    "Let's Go",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "fullfill your needs!",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () => context.read<AppBloc>().add(const AppLogoutRequested()),
                child: const Text('logout'),
              ),
            ],
          ),
          const Gap(20),
          Row(
            children: [
              Expanded(
                child: Container(
                  // margin: const EdgeInsets.only(left: 14),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  height: MediaQuery.of(context).size.height / 15,
                  decoration: BoxDecoration(
                    color: FlexColor.sakuraLightSecondaryContainer,
                    // border: Border.all(width: 1, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search,
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => context.goNamed("list_search"),
                          child: Material(
                            color: transaparentColor,
                            child: const Text(
                              "Search . . .",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  refresh() {
    context.read<AllCategoryBloc>().add(OnGetAllCategory());
    context.read<AllServicesBloc>().add(OnGetAllServices());
  }

  @override
  void dispose() {
    searchController.dispose();
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<AllServicesBloc>().add(OnGetAllServices());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll);
  }
}
