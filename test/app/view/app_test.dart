import 'package:disposable_playground/app/app.dart';
import 'package:disposable_playground/src/features/authentication/presentation/views/login_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(LoginPage), findsOneWidget);
    });
  });
}
