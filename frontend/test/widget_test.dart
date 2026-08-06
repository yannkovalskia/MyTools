import 'package:flutter_test/flutter_test.dart';

import 'package:frontend/main.dart';

void main() {
  testWidgets('App builds and shows Home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyToolsApp());
    expect(find.text('MyTools'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Downloader'), findsOneWidget);
    expect(find.text('Upscaler'), findsOneWidget);
    expect(find.text('Background'), findsOneWidget);
  });
}
