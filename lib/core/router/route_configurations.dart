import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:training/components/navigation.dart';
import 'package:training/core/router/route_constants.dart';
import 'package:training/modules/screens.dart';

GoRouter routerConfig = GoRouter(
  routes: [
    /// Welcome
    GoRoute(
        name: RouterConstants.welcome,
        path: '/',
        pageBuilder: (context, state) {
          return const MaterialPage(child: WelcomeScreen());
        }),

    /// Login
    GoRoute(
        name: RouterConstants.login,
        path: '/signIn',
        pageBuilder: (context, state) {
          return const MaterialPage(child: LoginScreen());
        }),

    /// Sign-up
    GoRoute(
        name: RouterConstants.signup,
        path: '/signUp',
        pageBuilder: (context, state) {
          return const MaterialPage(child: const SignUpScreen());
        }),

    /// Home
    GoRoute(
      name: RouterConstants.home,
      path: '/home',
      pageBuilder: (context, state) {
        return const MaterialPage(
            child: NavigationBottomBar(
          indexScreen: 0,
        ));
      },
      routes: [
        // wordDetails
        GoRoute(
          name: RouterConstants.wordDetail,
          path: 'wordDetail',
          pageBuilder: (context, state) {
            var params = state.extra as WordDetailScreen;
            return MaterialPage(
                child: WordDetailScreen(
              word: params.word,
              dictionaryType: params.dictionaryType,
            ));
          },
        ),
        // conversation
        GoRoute(
          name: RouterConstants.conversation,
          path: 'conversation',
          pageBuilder: (context, state) {
            return const MaterialPage(child: ConversationScreen());
          },
        ),
        // essentialWord
        GoRoute(
          name: RouterConstants.essentialWord,
          path: 'essentialWord',
          pageBuilder: (context, state) {
            return const MaterialPage(child: EssentialWordScreen());
          },
        ),
        // tipLearning
        GoRoute(
          name: RouterConstants.tipLearning,
          path: 'tipLearning',
          pageBuilder: (context, state) {
            return const MaterialPage(child: TipLeaningScreen());
          },
        ),
      ],
    ),

    /// Translate
    GoRoute(
      name: RouterConstants.translate,
      path: '/translate',
      pageBuilder: (context, state) {
        return const MaterialPage(
            child: NavigationBottomBar(
          indexScreen: 1,
        ));
      },
    ),

    /// Profile
    GoRoute(
      name: RouterConstants.profile,
      path: '/profile',
      pageBuilder: (context, state) {
        return const MaterialPage(
            child: NavigationBottomBar(
          indexScreen: 2,
        ));
      },
    ),
  ],
);
