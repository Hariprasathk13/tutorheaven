import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:tutorheaven/app/modules/Chat/bindings/ChatBinding.dart';
import 'package:tutorheaven/app/modules/Chat/views/ChatPage.dart';
import 'package:tutorheaven/app/modules/Home/views/HomePage.dart';
import 'package:tutorheaven/app/modules/Quiz/bindings/QuizBinding.dart';
import 'package:tutorheaven/app/modules/Quiz/views/QuizPage.dart';
import 'package:tutorheaven/app/modules/Quiz/views/result.dart';
import 'package:tutorheaven/app/modules/Summary/Views/SummaryPage.dart';
import 'package:tutorheaven/app/modules/Summary/bindings/SummaryBinding.dart';
import 'package:tutorheaven/app/modules/Transcript/bindings/TranscriptBinding.dart';
import 'package:tutorheaven/app/modules/Transcript/views/Player.dart';
import 'package:tutorheaven/common/SplashScreen.dart';

class AppRoutes {
  static List<GetPage<dynamic>> routes = [
    GetPage(name: '/splash', page: ()=>SplashScreen()),
    GetPage(
      name: '/',
      page: () => HomePage(),
      binding: TranscriptBinding(),
    ),
    GetPage(
        name: '/player',
        page: () => const YoutubePlayerScreen(),
        bindings: [TranscriptBinding(), SummaryBinding()]),
    GetPage(name: '/sum', page: () => SummaryPage(), binding: SummaryBinding()),
    GetPage(
        name: '/chat',
        page: () => ChatPage(),
        bindings: [ChatBinding(), SummaryBinding()]),
    GetPage(
        name: '/quiz',
        page: () => QuizPage(),
        bindings: [QuizBinding(), TranscriptBinding()]),
    GetPage(
      name: '/res',
      page: () => ResultPage(),
    )
  ];
}
