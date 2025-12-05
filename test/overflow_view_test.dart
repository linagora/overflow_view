import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:overflow_view/overflow_view.dart';

void main() {
  testWidgets(
    'the overflow indicator is not built if there is enough room (except for flexible)',
    (tester) async {
      int buildCount = 0;
      await tester.pumpWidget(
        Center(
          child: SizedBox(
            width: 100,
            child: OverflowView(
              builder: (context, count) {
                buildCount++;
                return const SizedBox();
              },
              children: [const SizedBox(width: 100)],
            ),
          ),
        ),
      );
      expect(buildCount, 0);

      await tester.pumpWidget(
        Center(
          child: SizedBox(
            width: 100,
            child: OverflowView.flexible(
              builder: (context, count) {
                buildCount++;
                return const SizedBox();
              },
              children: [const SizedBox(width: 100)],
            ),
          ),
        ),
      );
      expect(buildCount, 1);
    },
  );

  testWidgets(
    'the overflow indicator is built if there is not enough room',
    (tester) async {
      int buildCount = 0;
      late int remainingCount;
      await tester.pumpWidget(
        Center(
          child: SizedBox(
            width: 100,
            child: OverflowView(
              builder: (context, count) {
                buildCount++;
                remainingCount = count;
                return const SizedBox();
              },
              children: [
                const SizedBox(width: 50),
                const SizedBox(width: 50),
                const SizedBox(width: 50),
                const SizedBox(width: 50),
              ],
            ),
          ),
        ),
      );
      expect(buildCount, 1);
      expect(remainingCount, 3);

      buildCount = 0;

      await tester.pumpWidget(
        Center(
          child: SizedBox(
            width: 100,
            child: OverflowView.flexible(
              builder: (context, count) {
                buildCount++;
                remainingCount = count;
                return const SizedBox(width: 30);
              },
              children: [
                const SizedBox(width: 50),
                const SizedBox(width: 20),
                const SizedBox(width: 50),
                const SizedBox(width: 50),
              ],
            ),
          ),
        ),
      );
      expect(buildCount, 1);
      expect(remainingCount, 2);
    },
  );

  testWidgets(
    'children are layed out according to direction',
    (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: 100,
              width: 100,
              child: OverflowView(
                builder: (context, count) {
                  return const SizedBox();
                },
                children: [
                  const _Text('A'),
                  const _Text('B'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(tester.getTopLeft(find.text('A')), const Offset(0, 0));
      expect(tester.getTopLeft(find.text('B')), const Offset(50, 0));

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: 100,
              width: 100,
              child: OverflowView(
                direction: Axis.vertical,
                builder: (context, count) {
                  return const SizedBox();
                },
                children: [
                  const _Text('A'),
                  const _Text('B'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(tester.getTopLeft(find.text('A')), const Offset(0, 0));
      expect(tester.getTopLeft(find.text('B')), const Offset(0, 50));
    },
  );

  testWidgets(
    'children are layed out according to direction and spacing',
    (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: 110,
              width: 110,
              child: OverflowView(
                spacing: 10,
                builder: (context, count) {
                  return const SizedBox();
                },
                children: [
                  const _Text('A'),
                  const _Text('B'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(tester.getTopLeft(find.text('A')), const Offset(0, 0));
      expect(tester.getTopLeft(find.text('B')), const Offset(60, 0));

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: 110,
              width: 110,
              child: OverflowView(
                spacing: 10,
                direction: Axis.vertical,
                builder: (context, count) {
                  return const SizedBox();
                },
                children: [
                  const _Text('A'),
                  const _Text('B'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(tester.getTopLeft(find.text('A')), const Offset(0, 0));
      expect(tester.getTopLeft(find.text('B')), const Offset(0, 60));

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: 110,
              width: 110,
              child: OverflowView.flexible(
                spacing: 10,
                builder: (context, count) {
                  return const SizedBox();
                },
                children: [
                  const _Text('A'),
                  const _Text('B'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(tester.getTopLeft(find.text('A')), const Offset(0, 0));
      expect(tester.getTopLeft(find.text('B')), const Offset(60, 0));

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: 110,
              width: 110,
              child: OverflowView.flexible(
                spacing: 10,
                direction: Axis.vertical,
                builder: (context, count) {
                  return const SizedBox();
                },
                children: [
                  const _Text('A'),
                  const _Text('B'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(tester.getTopLeft(find.text('A')), const Offset(0, 0));
      expect(tester.getTopLeft(find.text('B')), const Offset(0, 60));
    },
  );

  testWidgets(
    'spacing can be negative for overlapping effect',
    (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: 110,
              width: 110,
              child: OverflowView(
                spacing: -10,
                builder: (context, count) {
                  return const SizedBox();
                },
                children: [
                  const _Text('A'),
                  const _Text('B'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(tester.getTopLeft(find.text('A')), const Offset(0, 0));
      expect(tester.getTopLeft(find.text('B')), const Offset(40, 0));
    },
  );

  testWidgets(
    'OverflowView.flexible should build builder twice if there is not enough room for it the first time',
    (tester) async {
      int buildCount = 0;
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: 150,
              width: 150,
              child: OverflowView.flexible(
                builder: (context, count) {
                  buildCount++;
                  return const SizedBox(
                    width: 100,
                  );
                },
                children: [
                  const _Text('A'),
                  const _Text('B'),
                  const _Text('C'),
                  const _Text('D'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(buildCount, 2);
      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsNothing);
      expect(find.text('C'), findsNothing);
      expect(find.text('E'), findsNothing);
    },
  );

  testWidgets(
    'unmount successfully the overflow indicator once it has already been laid '
    'out with .flexible()',
    (tester) async {
      await tester.pumpWidget(
        Center(
          child: SizedBox(
            width: 100,
            child: OverflowView.flexible(
              builder: (context, count) {
                return const SizedBox(width: 30);
              },
              children: [
                const SizedBox(width: 50),
                const SizedBox(width: 20),
                const SizedBox(width: 50),
                const SizedBox(width: 50),
              ],
            ),
          ),
        ),
      );

      await tester.pumpWidget(
        Center(
          child: SizedBox(
            width: 100,
            child: OverflowView.flexible(
              builder: (context, count) {
                return const SizedBox(width: 30);
              },
              children: [
                const SizedBox(width: 50),
              ],
            ),
          ),
        ),
      );
    },
  );

  testWidgets(
    'reverse mode trims from the start instead of the end (horizontal)',
    (tester) async {
      late int remainingCount;
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: 100,
              width: 150,
              child: OverflowView(
                reverse: true,
                builder: (context, count) {
                  remainingCount = count;
                  return const SizedBox(width: 50, height: 50);
                },
                children: [
                  const _Text('A'),
                  const _Text('B'),
                  const _Text('C'),
                  const _Text('D'),
                  const _Text('E'),
                ],
              ),
            ),
          ),
        ),
      );

      // Should show overflow indicator + D + E (hiding A, B, and C)
      expect(find.text('A'), findsNothing);
      expect(find.text('B'), findsNothing);
      expect(find.text('C'), findsNothing);
      expect(find.text('D'), findsOneWidget);
      expect(find.text('E'), findsOneWidget);
      expect(remainingCount, 3);

      // Overflow indicator should be at the start (position 0)
      expect(tester.getTopLeft(find.text('D')), const Offset(50, 0));
      expect(tester.getTopLeft(find.text('E')), const Offset(100, 0));
    },
  );

  testWidgets(
    'reverse mode trims from the start instead of the end (vertical)',
    (tester) async {
      late int remainingCount;
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: 150,
              width: 100,
              child: OverflowView(
                reverse: true,
                direction: Axis.vertical,
                builder: (context, count) {
                  remainingCount = count;
                  return const SizedBox(width: 50, height: 50);
                },
                children: [
                  const _Text('A'),
                  const _Text('B'),
                  const _Text('C'),
                  const _Text('D'),
                  const _Text('E'),
                ],
              ),
            ),
          ),
        ),
      );

      // Should show overflow indicator + D + E (hiding A, B, and C)
      expect(find.text('A'), findsNothing);
      expect(find.text('B'), findsNothing);
      expect(find.text('C'), findsNothing);
      expect(find.text('D'), findsOneWidget);
      expect(find.text('E'), findsOneWidget);
      expect(remainingCount, 3);

      // Overflow indicator should be at the start (position 0)
      expect(tester.getTopLeft(find.text('D')), const Offset(0, 50));
      expect(tester.getTopLeft(find.text('E')), const Offset(0, 100));
    },
  );

  testWidgets(
    'reverse mode with flexible layout trims from the start',
    (tester) async {
      late int remainingCount;
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: 100,
              width: 140,
              child: OverflowView.flexible(
                reverse: true,
                builder: (context, count) {
                  remainingCount = count;
                  return const SizedBox(width: 30, height: 50);
                },
                children: [
                  const SizedBox(width: 40, height: 50),
                  const SizedBox(width: 50, height: 50),
                  const SizedBox(width: 60, height: 50),
                  const SizedBox(width: 20, height: 50),
                ],
              ),
            ),
          ),
        ),
      );

      // With 140px width and reverse mode, should fit:
      // overflow indicator (30px) + 60px + 20px = 110px
      // Should hide the first two children (40px and 50px)
      expect(remainingCount, 2);
    },
  );

  testWidgets(
    'reverse mode respects spacing',
    (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: 100,
              width: 170,
              child: OverflowView(
                reverse: true,
                spacing: 10,
                builder: (context, count) {
                  return const SizedBox(width: 50, height: 50);
                },
                children: [
                  const _Text('A'),
                  const _Text('B'),
                  const _Text('C'),
                  const _Text('D'),
                ],
              ),
            ),
          ),
        ),
      );

      // Should show overflow indicator + C + D
      expect(find.text('A'), findsNothing);
      expect(find.text('B'), findsNothing);
      expect(find.text('C'), findsOneWidget);
      expect(find.text('D'), findsOneWidget);

      // Check positions with spacing (overflow indicator at 0, then 10px spacing)
      expect(tester.getTopLeft(find.text('C')), const Offset(60, 0));
      expect(tester.getTopLeft(find.text('D')), const Offset(120, 0));
    },
  );

  testWidgets(
    'non-reverse mode still works as expected',
    (tester) async {
      late int remainingCount;
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: 100,
              width: 150,
              child: OverflowView(
                reverse: false,
                builder: (context, count) {
                  remainingCount = count;
                  return const SizedBox(width: 50, height: 50);
                },
                children: [
                  const _Text('A'),
                  const _Text('B'),
                  const _Text('C'),
                  const _Text('D'),
                  const _Text('E'),
                ],
              ),
            ),
          ),
        ),
      );

      // Should show A + B + overflow indicator (hiding C, D, E)
      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
      expect(find.text('C'), findsNothing);
      expect(find.text('D'), findsNothing);
      expect(find.text('E'), findsNothing);
      expect(remainingCount, 3);

      expect(tester.getTopLeft(find.text('A')), const Offset(0, 0));
      expect(tester.getTopLeft(find.text('B')), const Offset(50, 0));
    },
  );
}

class _Text extends StatelessWidget {
  const _Text(
    this.text, {
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: Text(text),
    );
  }
}
