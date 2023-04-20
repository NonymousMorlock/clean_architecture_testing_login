import 'package:disposable_playground/src/features/authentication/presentation/views/login_page.dart';
import 'package:disposable_playground/src/features/authentication/presentation/widgets/auth_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/helpers.dart';

void main() {
  testWidgets(
    'should render [LoginPage] and [AuthField]s',
        (tester) async {
      await tester.pumpApp(const LoginPage());
      await tester.pumpAndSettle();
      expect(find.byType(LoginPage), findsOneWidget);
      expect(find.byType(AuthField), findsNWidgets(2));
    },
  );

  testWidgets(
    'should display error when fields are empty',
        (tester) async {
      await tester.pumpApp(const LoginPage());
      await tester.pumpAndSettle();
      final signInButton = find.byWidgetPredicate(
            (widget) =>
        widget is ElevatedButton &&
            widget.child != null && widget.child is Text &&
            (widget.child! as Text).data!.toLowerCase().contains('sign in'),
      );
      await tester.tap(signInButton);
      await tester.pumpAndSettle();
      expect(find.text('Please enter your Email'), findsOneWidget);
    },
  );
}
