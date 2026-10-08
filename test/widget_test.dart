import 'package:ecowalk_app/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('EcoWalk app dapat dibuka', (WidgetTester tester) async {
    await tester.pumpWidget(const EcoWalkApp());

    expect(find.text('"Bandingkan, pilih, liburan tanpa ragu!"'),
        findsOneWidget);
  });
}
