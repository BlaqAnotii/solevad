// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:go_router/go_router.dart';
import 'package:oavltd/main.dart';
import 'package:oavltd/screen/about_us.dart';
import 'package:oavltd/screen/our_service.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(),
      routes: <RouteBase>[
      
        GoRoute(
          path: 'home',
          builder: (context, GoRouterState state) {
            return const MyHomePage();
          },
        ),
        GoRoute(
          path: 'About_Us',
          builder: (context, GoRouterState state) {
            return const AboutUsScreen();
          },
        ),
        GoRoute(
          path: 'Our_Services',
          builder: (context, GoRouterState state) {
            return const OurServiceScreen();
          },
        ),
        //  GoRoute(
        //   path: 'login',
        //   builder: (context, GoRouterState state) {
        //     return const Logi();
        //   },
        // ),
        //  GoRoute(
        //   path: 'verification',
        //   builder: (context, GoRouterState state) {
        //     return const VerificationView();
        //   },
        // ),
        // GoRoute(
        //   path: 'create-business',
        //   builder: (context, GoRouterState state) {
        //     return const CreateBusinessView();
        //   },
        // ),
        // GoRoute(
        //   path: 'join-business',
        //   builder: (context, GoRouterState state) {
        //     return const JoinBusinessView();
        //   },
        // )
      ],
    ),
  ],
);
    await tester.pumpWidget( MyApp(router: router,));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
