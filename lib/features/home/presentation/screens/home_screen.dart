// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:hidable/hidable.dart';
import 'package:ma3refa_mobile/core/cache/cache_helper.dart';
import 'package:ma3refa_mobile/core/services/get_it_services.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/core/utils/audio_service.dart';
import 'package:ma3refa_mobile/core/utils/custom_snackbar.dart';
import 'package:ma3refa_mobile/features/auth/data/models/user_model.dart';
import 'package:ma3refa_mobile/features/home/cubit/home_cubit.dart';
import 'package:ma3refa_mobile/features/home/cubit/home_states.dart';
import 'package:ma3refa_mobile/features/home/presentation/screens/error_at_home_widget.dart';
import 'package:ma3refa_mobile/features/home/presentation/widgets/categories_grid_widget.dart';
import 'package:ma3refa_mobile/features/home/presentation/widgets/home_header_widget.dart';
import 'package:ma3refa_mobile/features/home/presentation/widgets/recommendation_slider_widget.dart';
import 'package:ma3refa_mobile/features/profile/cubit/profile/profile_cubit.dart';

class HomeScreen extends StatefulWidget {
  final String? userName;
  final String? gender;
  const HomeScreen({super.key, this.userName, this.gender});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  String currentUserName = "Guest";
  String currentGender = "male";

  @override
  void initState() {
    super.initState();
    _loadUserData();
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    if (homeCubit.state is HomeInitialState) {
      homeCubit.getAllHomeCategories();
    }
    BlocProvider.of<ProfileCubit>(context).fetchProfileHistory();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    getIt<AudioService>().stopSound();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final UserModel userData = await CacheHelper.getUserData();
    setState(() {
      currentUserName = widget.userName ?? userData.name;
      currentGender = widget.gender ?? userData.gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeStates>(
          builder: (BuildContext context, HomeStates state) {
            final homeCubit = BlocProvider.of<HomeCubit>(context);
            final allCategoriesModel = state is HomeCategoriesSuccessState
                ? state.allCategoriesModel
                : homeCubit.lastHomeCategoriesModel;

            if (state is HomeCategoriesLoadingState &&
                allCategoriesModel == null) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeInitialState &&
                allCategoriesModel == null) {
              BlocProvider.of<HomeCubit>(context).getAllHomeCategories();
              return const Center(child: CircularProgressIndicator());
            } else if (allCategoriesModel != null) {
              return Stack(
                children: [
                  RefreshIndicator(
                    edgeOffset: 130.h,
                    onRefresh: () async {
                      await BlocProvider.of<HomeCubit>(
                        context,
                      ).getAllHomeCategories();
                      CustomSnackBar.show(
                        context: context,
                        title: "Home Refreshed! 🎉",
                        message:
                            "Your home screen has been updated with the latest content.",
                        contentType: ContentType.success,
                      );
                    },
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        top: 150.h,
                        bottom: 20.h,
                        left: 16.w,
                        right: 16.w,
                      ),
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              'home.homeScreen.recommendedForYou'.tr(),
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: AppColors.textDark,
                              ),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              'home.homeScreen.recommendedSubtitle'.tr(),
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.textLight,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          RecommendationSliderWidget(
                            allCategoriesModel: allCategoriesModel,
                          ),

                          SizedBox(height: 20.h),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              'home.homeScreen.exploreCategories'.tr(),
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          CategoriesGridWidget(
                            allCategoriesModel: allCategoriesModel,
                          ),
                          SizedBox(height: 30.h),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15.h,
                    left: 0,
                    right: 0,
                    child: Hidable(
                      preferredWidgetSize: Size.fromHeight(100.h),
                      controller: _scrollController,
                      wOpacity: true,
                      child: InkWell(
                        onTap: () {
                          ZoomDrawer.of(context)!.toggle();
                        },
                        child: HomeHeaderWidget(
                          userName: currentUserName,
                          gender: currentGender,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is HomeCategoriesErrorState) {
              return ErrorHomeWidget(errorMessage: state.error);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
