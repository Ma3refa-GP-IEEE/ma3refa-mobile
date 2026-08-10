class ApiConsts {
  static const String baseUrl = 'https://mock.ma3refa.local/api/';
  static const String loginEndpoint = 'auth/login';
  static const String registerEndpoint = 'auth/register';
  static const String allCategoriesEndpoint = 'categories';
  static const String userProfileEndpoint = 'user/profile';
  static const String generateQuizEndpoint = 'quiz/generate';
  static String quizzesHistoryEndpoint(int subcategoryId) =>
      '/user/subcategories/$subcategoryId/quizzes';
  static String subcategoriesEndpoint(int categoryId) =>
      'categories/$categoryId/subcategories';
  static String finishQuizEndpoint(int quizId) => 'quiz/$quizId/finish';
  static String quizDetailsEndpoint(int quizId) => 'quiz/$quizId';
}
