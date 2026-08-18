// ignore_for_file: deprecated_member_use
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
import 'package:ma3refa_mobile/features/home/presentation/screens/home_screen.dart';
import 'package:ma3refa_mobile/features/profile/cubit/profile/profile_cubit.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/question_model.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/quiz_details_model.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/widgets/quiz_review_item_widget.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/widgets/quiz_score_card_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class ResultScreen extends StatefulWidget {
  final bool comingFromQuizScreen;
  final QuizDetailsModel quizDetailsModel;

  const ResultScreen({
    super.key,
    required this.quizDetailsModel,
    required this.comingFromQuizScreen,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int numberOfCorrectAnswers() {
    int correctAnswers = 0;
    for (var result in widget.quizDetailsModel.results) {
      if (result.isCorrect) {
        correctAnswers++;
      }
    }
    return correctAnswers;
  }

  String getFullAnswerText(QuestionModel question, String? answerLetter) {
    switch (answerLetter?.toLowerCase()) {
      case 'a':
        return question.optionA;
      case 'b':
        return question.optionB;
      case 'c':
        return question.optionC;
      case 'd':
        return question.optionD;
      case null:
        return 'You Skipped this question or did not answer it.';
      default:
        return answerLetter ??
            'You Skipped this question or did not answer it.';
    }
  }

  @override
  initState() {
    super.initState();
    final String difficulty = widget.quizDetailsModel.difficulty;
    final int difficultyLevel = difficulty == 'easy'
        ? 1
        : difficulty == 'medium'
        ? 2
        : difficulty == 'hard'
        ? 3
        : 0;
    !widget.comingFromQuizScreen
        ? null
        : widget.quizDetailsModel.score / difficultyLevel ==
              widget.quizDetailsModel.totalQuestions
        ? getIt<AudioService>().playAssetSound(
            'sounds/dexter_if_userscore_equals_100.mp3',
          )
        : widget.quizDetailsModel.score / difficultyLevel >=
              widget.quizDetailsModel.totalQuestions / 2
        ? getIt<AudioService>().playAssetSound(
            'sounds/if_userscore_greaterthan_50.mp3',
          )
        : getIt<AudioService>().playAssetSound(
            'sounds/under_50_percent_arabic.mp3',
          );
    if (widget.comingFromQuizScreen &&
        widget.quizDetailsModel.totalQuestions == numberOfCorrectAnswers()) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        CustomSnackBar.show(
          context: context,
          title: '10/10! Hacker vibes 💻✨',
          message: 'We promise not to check your browser history. 😆',
          contentType: ContentType.success,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('quiz_results'.tr()),
        centerTitle: true,
        backgroundColor: AppColors.background,
        leading: !widget.comingFromQuizScreen
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : null,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.r),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              QuizScoreCardWidget(
                totalQuestions: widget.quizDetailsModel.totalQuestions,
                correctAnswers: numberOfCorrectAnswers(),
              ),
              SizedBox(height: 20.h),
              if (!widget.comingFromQuizScreen)
                _buildDateWidget(widget.quizDetailsModel.createdAt),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'review_answers'.tr(),
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.quizDetailsModel.results.length,
                itemBuilder: (context, index) {
                  final result = widget.quizDetailsModel.results[index];
                  String actualCorrectAnswerText = getFullAnswerText(
                    result.question,
                    result.question.correctAnswer,
                  );

                  String actualUserAnswerText = getFullAnswerText(
                    result.question,
                    result.selectedAnswer,
                  );
                  return QuizReviewItemWidget(
                        questionNumber: index + 1,
                        questionText: result.question.description,
                        correctAnswer: actualCorrectAnswerText,
                        userAnswer: actualUserAnswerText,
                        isCorrect: result.isCorrect,
                        explanation: result.explanation,
                      )
                      .animate()
                      .fade(duration: 400.ms, delay: (index * 150).ms)
                      .slideY(
                        begin: 0.2,
                        duration: 400.ms,
                        delay: (index * 150).ms,
                        curve: Curves.easeOutQuad,
                      );
                },
              ),
              SizedBox(height: 20.h),
              widget.comingFromQuizScreen
                  ? CustomButton(
                          onPressed: () {
                            BlocProvider.of<ProfileCubit>(
                              context,
                            ).fetchProfileHistory();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          },
                          text: 'back_to_home'.tr(),
                          icon: Icons.home,
                        )
                        .animate(delay: 1.seconds)
                        .fadeIn()
                        .scale(curve: Curves.easeOutBack)
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateWidget(DateTime? date) {
    try {
      if (date == null) return const SizedBox.shrink();

      final String formattedDate = DateFormat(
        'dd MMM yyyy, hh:mm a',
      ).format(date);

      return Container(
        margin: EdgeInsets.only(bottom: 20.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.calendar_today_rounded,
              color: AppColors.primary,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              "$formattedDate\n ${timeago.format(date)}",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
      ).animate().fade(duration: 500.ms).slideY(begin: -0.2);
    } catch (e) {
      return const SizedBox.shrink();
    }
  }
}
