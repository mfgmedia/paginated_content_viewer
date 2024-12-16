import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:paginated_content_viewer/paginated_content_viewer.dart';

void main() {
  testWidgets('PaginatedContentViewer renders correctly', (WidgetTester tester) async {
    // Define a page controller for testing
    final pageController = PageController();

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: PaginatedContentViewer(
          pageController: pageController,
          children: const [
            Text('Page 1'),
            Text('Page 2'),
            Text('Page 3'),
          ],
        ),
      ),
    );

    // Check initial content
    expect(find.text('Page 1'), findsOneWidget);
    expect(find.text('Page 2'), findsNothing);

    // Trigger a manual page change
    pageController.jumpToPage(1);
    await tester.pumpAndSettle();

    // Verify content after the change
    expect(find.text('Page 1'), findsNothing);
    expect(find.text('Page 2'), findsOneWidget);
  });

  testWidgets('Indicator appears and updates', (WidgetTester tester) async {
    final pageController = PageController();

    await tester.pumpWidget(
      MaterialApp(
        home: PaginatedContentViewer(
          pageController: pageController,
          children: const [
            Text('Page A'),
            Text('Page B'),
            Text('Page C'),
          ],
        ),
      ),
    );

    // Find CustomPaint only under the Positioned widget
    final indicatorFinder = find.descendant(
      of: find.byType(Positioned),
      matching: find.byType(CustomPaint),
    );

    // Ensure one matching indicator exists
    expect(indicatorFinder, findsOneWidget);

    // Jump to another page
    pageController.jumpToPage(2);
    await tester.pumpAndSettle();

    // Re-check the indicator presence
    expect(indicatorFinder, findsOneWidget);
  });
}
