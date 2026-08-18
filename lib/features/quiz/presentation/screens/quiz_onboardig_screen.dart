// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks, deprecated_member_use

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/services/get_it_services.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/core/utils/audio_service.dart';
import 'package:ma3refa_mobile/core/utils/custom_snackbar.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/custome_button.dart';
import 'package:ma3refa_mobile/features/quiz/cubit/quiz_cubit.dart';
import 'package:ma3refa_mobile/features/quiz/cubit/quiz_states.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/quiz_setup_params.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/screens/timed_quiz_questions_screen.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/screens/untimed_quiz_questions_screen.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/widgets/loading_card_widget.dart';

class QuizOnBoardingScreen extends StatefulWidget {
  final int quizTime;
  final String quizTitle;
  final QuizSetupParams quizSetupParams;
  const QuizOnBoardingScreen({
    super.key,
    required this.quizSetupParams,
    required this.quizTitle,
    required this.quizTime,
  });

  @override
  State<QuizOnBoardingScreen> createState() => _QuizOnBoardingScreenState();
}

class _QuizOnBoardingScreenState extends State<QuizOnBoardingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIt<AudioService>().playAssetSound('sounds/searching_sound.mp3');
    });
    BlocProvider.of<QuizCubit>(
      context,
    ).generateNewQuiz(params: widget.quizSetupParams);
  }

  @override
  void dispose() {
    getIt<AudioService>().stopSound();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isRtl = Directionality.of(context) == TextDirection.RTL;
    return BlocConsumer<QuizCubit, QuizState>(
      listener: (context, state) {
        if (state is GenerateQuizErrorState) {
          CustomSnackBar.show(
            context: context,
            title: 'Error',
            message: state.errorMessage,
            contentType: ContentType.failure,
          );

          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              Navigator.pop(context);
            }
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'almost_ready'.tr(),
                          style: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h),
                      LoadingCardWidget(width: 275.w, height: 305.h),
                      SizedBox(height: 25.h),

                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'quick_tips'.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.normal,
                            color: AppColors.textLight,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      ...[
                            _buildTipCard(
                              tip: 'tip_read_questions'.tr(),
                              icon: Icons.lightbulb_outline,
                            ),
                            _buildTipCard(
                              tip: 'tip_timer'.tr(),
                              icon: Icons.timer,
                            ),
                            _buildTipCard(
                              tip: 'tip_do_best'.tr(),
                              icon: Icons.sentiment_satisfied_alt,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 15.h),
                              child: Center(
                                child: CustomButton(
                                  onPressed: () {
                                    if (state is GenerateQuizSuccessState) {
                                      widget.quizTime == 0
                                          ? Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    UntimedQuizQuestionsScreen(
                                                      subCategoryId: widget
                                                          .quizSetupParams
                                                          .subcategoryId,
                                                      quizModel: state.quiz,
                                                      numberOfQuestions: widget
                                                          .quizSetupParams
                                                          .numberOfQuestions,
                                                      quizTitle:
                                                          widget.quizTitle,
                                                      quizTime: widget.quizTime,
                                                      difficultyLevel: widget
                                                          .quizSetupParams
                                                          .difficulty,
                                                    ),
                                              ),
                                            )
                                          : Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    TimedQuizQuestionsScreen(
                                                      subCategoryId: widget
                                                          .quizSetupParams
                                                          .subcategoryId,
                                                      quizModel: state.quiz,
                                                      numberOfQuestions: widget
                                                          .quizSetupParams
                                                          .numberOfQuestions,
                                                      quizTitle:
                                                          widget.quizTitle,
                                                      quizTime: widget.quizTime,
                                                      difficultyLevel: widget
                                                          .quizSetupParams
                                                          .difficulty,
                                                    ),
                                              ),
                                            );
                                    } else {
                                      CustomSnackBar.show(
                                        context: context,
                                        title: 'Please Wait',
                                        message:
                                            'Preparing your quiz, please wait...',
                                        contentType: ContentType.help,
                                      );
                                    }
                                  },
                                  text: state is GenerateQuizSuccessState
                                      ? 'get_started'.tr()
                                      : 'Preparing...'.tr(),
                                  icon: state is GenerateQuizSuccessState
                                      ? Icons.arrow_forward
                                      : Icons.hourglass_bottom_outlined,
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                          ]
                          .animate(interval: 1.seconds)
                          .fade(duration: 500.ms)
                          .slideX(
                            begin: isRtl ? 1.0 : -1.0,
                            duration: 500.ms,
                            curve: Curves.easeOutBack,
                          ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Card _buildTipCard({required String tip, required IconData icon}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(12.0.r),
        child: ListTile(
          leading: Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          title: Text(
            tip,
            style: TextStyle(fontSize: 16.sp, color: AppColors.textDark),
          ),
        ),
      ),
    );
  }
}
