// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:ui';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hidable/hidable.dart';
import 'package:ma3refa_mobile/core/cache/cache_helper.dart';
import 'package:ma3refa_mobile/core/services/get_it_services.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/core/utils/audio_service.dart';
import 'package:ma3refa_mobile/core/utils/custom_snackbar.dart';
import 'package:ma3refa_mobile/features/auth/data/models/user_model.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/custome_button.dart';
import 'package:ma3refa_mobile/features/home/cubit/home_cubit.dart';
import 'package:ma3refa_mobile/features/home/cubit/home_states.dart';
import 'package:ma3refa_mobile/features/home/presentation/screens/error_at_home_widget.dart';
import 'package:ma3refa_mobile/features/home/presentation/widgets/categories_grid_widget.dart';
import 'package:ma3refa_mobile/features/home/presentation/widgets/custome_drawer.dart';
import 'package:ma3refa_mobile/features/home/presentation/widgets/home_header_widget.dart';
import 'package:ma3refa_mobile/features/home/presentation/widgets/recommendation_slider_widget.dart';
import 'package:ma3refa_mobile/features/profile/cubit/profile/profile_cubit.dart';
import 'package:ma3refa_mobile/features/profile/cubit/profile/profile_state.dart';
import 'package:ma3refa_mobile/features/profile/presentation/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final String? userName;
  final String? gender;
  const HomeScreen({super.key, this.userName, this.gender});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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

  void _handleProfileTap() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      final profileState = BlocProvider.of<ProfileCubit>(context).state;
      if (profileState is ProfileSuccessState) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
      } else {
        BlocProvider.of<ProfileCubit>(context).fetchProfileHistory();
        CustomSnackBar.show(
          context: context,
          title: 'Error',
          message: 'Failed to load profile. Please try again.',
          contentType: ContentType.failure,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        final ScaffoldState? scaffoldState = _scaffoldKey.currentState;

        if (scaffoldState != null && scaffoldState.isDrawerOpen) {
          scaffoldState.closeDrawer();
          return;
        }

        final bool? shouldExit = await showDialog<bool>(
          context: context,
          builder: (context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFCBEBE7),
                  borderRadius: BorderRadius.circular(32.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.sentiment_dissatisfied_rounded,
                        color: const Color(0xFF133F53),
                        size: 40.sp,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Leaving so soon? 😢",
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF133F53),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Are you sure you want to exit the app?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF4A6572),
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: 28.h),
                    Column(
                      children: [
                        CustomButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          text: 'stay_connected'.tr(),
                          textColor: AppColors.textDark,
                          buttonColor: Colors.green.shade600,
                        ),
                        SizedBox(height: 6.w),
                        CustomButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          text: "Yes, Exit",
                          textColor: Colors.black,
                          buttonColor: Colors.grey.shade300,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

        if (shouldExit == true) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.background,
        drawer: Drawer(
          width: MediaQuery.of(context).size.width * 0.80,
          backgroundColor: AppColors.secondaryBackground,
          child: CustomDrawer(
            userName: currentUserName,
            gender: currentGender,
            onProfileTap: () {
              Navigator.of(context).pop();
              _handleProfileTap();
            },
          ),
        ),
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
                            Scaffold.of(context).openDrawer();
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
      ),
    );
  }
}
