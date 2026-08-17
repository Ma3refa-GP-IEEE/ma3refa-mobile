import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:ma3refa_mobile/core/cache/cache_helper.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/core/utils/custom_snackbar.dart';
import 'package:ma3refa_mobile/features/auth/data/models/user_model.dart';
import 'package:ma3refa_mobile/features/home/presentation/screens/home_screen.dart';
import 'package:ma3refa_mobile/features/home/presentation/widgets/custome_drawer.dart';
import 'package:ma3refa_mobile/features/profile/cubit/profile/profile_cubit.dart';
import 'package:ma3refa_mobile/features/profile/cubit/profile/profile_state.dart';
import 'package:ma3refa_mobile/features/profile/presentation/screens/profile_screen.dart';

class HomeWrapper extends StatefulWidget {
  final String? userName;
  final String? gender;

  const HomeWrapper({super.key, this.userName, this.gender});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  final ZoomDrawerController zoomDrawerController = ZoomDrawerController();
  String currentUserName = "Guest";
  String currentGender = "male";

  @override
  void initState() {
    super.initState();
    _loadUserData();
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
    return ZoomDrawer(
      closeCurve: Curves.easeInOut,
      mainScreenScale: 0.8,
      controller: zoomDrawerController,

      menuScreen: CustomDrawer(
        userName: currentUserName,
        gender: currentGender,
        onProfileTap: () {
          zoomDrawerController.toggle?.call();

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
        },
      ),

      mainScreen: HomeScreen(userName: currentUserName, gender: currentGender),

      borderRadius: 24.r,
      showShadow: true,
      angle: -10.0,
      drawerShadowsBackgroundColor: Colors.grey.shade300,
      slideWidth: MediaQuery.of(context).size.width * 0.90,
      menuBackgroundColor: AppColors.secondaryBackground,
    );
  }
}
