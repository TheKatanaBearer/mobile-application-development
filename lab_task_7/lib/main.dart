// main.dart - Team Board lab
import 'dart:async';

import 'package:flutter/material.dart';

const String studentName = 'Hamza Khan Tariq';
const String rollNo = '04072313050';

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit

const List<String> courses = [
  'Mobile Dev',
  'Data Structures',
  'Operating Systems',
  'Databases',
  'Networks',
  'Software Eng',
  'AI',
  'Web Engineering',
  'Graphics',
  'Security',
];
const List<String> names = ['Ali', 'Sara', 'Omar', 'Hina', 'Zain', 'Maya'];
const List<String> mains = [
  'start',
  'center',
  'end',
  'spaceBetween',
  'spaceAround',
  'spaceEvenly',
];
const List<String> crosses = ['start', 'center', 'end'];
const List<String> hues = ['teal', 'indigo', 'orange', 'pink', 'green'];
const Map<String, MaterialColor> swatches = {
  'teal': Colors.teal,
  'indigo': Colors.indigo,
  'orange': Colors.orange,
  'pink': Colors.pink,
  'green': Colors.green,
};

final String course = courses[u];

// Steps 1-2: the clock
final int startSec = 5 * (1 + t % 5); // where the clock starts
final int tick = 1 + u % 3; // how much it adds every second
final int ticks = 4 + u % 4; // how many ticks until it stops
final int stopAt = startSec + ticks * tick; // the clock stops here

// Steps 4-5: the tiles
final String tileA = names[u % 6];
final String tileB = names[(u + 2) % 6];
final String tileC = names[(u + 4) % 6];
final int tapsToMake = 2 + t % 3; // used by the experiment in Step 5

// Step 6: axes (the NAMES are printed on the settings card; you type the enum)
final String mainName = mains[u % 6];
final String crossName = crosses[t % 3];

// Step 8: Expanded and Flexible
final double fixedW = 70.0 + 10 * u;
final int flexA = 1 + t % 3;
final int flexB = 1 + u % 2;

// Step 9: Container
final double boxMargin = 4.0 + 2 * (t % 5);
final double boxPad = 8.0 + 2 * (u % 5);
final double boxRadius = 4.0 * (1 + (t + u) % 4);
final double boxBorder = 1.0 + t % 3;
final String hue = hues[(t + u) % 5]; // use swatches[hue]!.shade100

// Step 10: Stack
final double dotTop = 4.0 + 4 * (t % 4);
final double dotRight = 4.0 + 4 * (u % 4);
final double dotBottom = 4.0 + 4 * ((t + u) % 4);
final double dotLeft = 4.0 + 4 * ((t + 2 * u) % 4);
// ===========================================================================

// Step 2 writes to this list from initState and dispose.
final List<String> lifecycleLog = <String>[];

void main() => runApp(const LabApp());

// Keep the name LabApp and its const constructor: the checker uses them.
class LabApp extends StatelessWidget {
  const LabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Team Board', home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Team Board: $course')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SettingsCard(),
            const SizedBox(height: 12),
            const Welcome(),
            const SizedBox(height: 12),
            const Clock(),
            const SizedBox(height: 12),
            const SwapBoard(),
            const SizedBox(height: 12),
            const InfoPanel(),
            const SizedBox(height: 12),
            const SummaryRow(),
            const SizedBox(height: 12),
            const ShareRow(),
            const SizedBox(height: 12),
            const InfoBox(),
            const SizedBox(height: 12),
            const StampStack(),
            // Add each new widget BELOW the previous one, in the order the
            // steps tell you, with a SizedBox(height: 12) between widgets.
          ],
        ),
      ),
    );
  }
}

// ---- Provided: shows YOUR numbers. Keep it on the page. Do not rename.
class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'YOUR SETTINGS (seed $seed)\n'
      'clock: start $startSec, tick $tick, stop at $stopAt\n'
      'tiles: $tileA, $tileB, $tileC (taps for the Step 5 experiment: $tapsToMake)\n'
      'row main axis: $mainName | column cross axis: $crossName\n'
      'flex: $flexA and $flexB | fixed width: ${fixedW.toStringAsFixed(0)}\n'
      'box: margin $boxMargin, padding $boxPad, radius $boxRadius, '
      'border $boxBorder, colour $hue\n'
      'stamp: top $dotTop, right $dotRight, bottom $dotBottom, left $dotLeft',
      key: const Key('settings'),
      style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
    );
  }
}

// ---- Provided for Step 7. It overflows on purpose. Do not rename anything.
class SummaryRow extends StatelessWidget {
  const SummaryRow({super.key});

  // Think: constraints go down, sizes go up. A bare Text gets an unbounded
  // [limitless] width constraint from the Row, so it asks for one long line
  // and the Row overflows. Expanded hands it a tight [fixed] maximum width
  // instead, so the Text must fit that width and wraps onto several lines.

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Part A: read the widget tree of the $course board from top to bottom.',
            key: const Key('sum-a'),
          ),
        ),
        Expanded(
          child: Text(
            'Part B: build each box from small widgets and never extend a built-in class.',
            key: const Key('sum-b'),
          ),
        ),
        Expanded(
          child: Text(
            'Part C: break the layout on purpose, then fix it with Expanded or Wrap.',
            key: const Key('sum-c'),
          ),
        ),
      ],
    );
  }
}

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  late Timer _timer;
  int _seconds = startSec;
  int _builds = 0;

  @override
  void initState() {
    super.initState();
    lifecycleLog.add('initState');
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _seconds += tick);
      if (_seconds >= stopAt) timer.cancel();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    lifecycleLog.add('dispose');
    super.dispose();
  }

  // Think (Step 1): initState runs exactly once per State object; build runs
  // on every rebuild. Started in build, each rebuild would spawn [create]
  // another Timer, all ticking at once, so the clock would accelerate
  // [get faster and faster] and never stop cleanly.

  // Think (Step 2): Builds rises by one per second because one Timer tick
  // calls setState once, and setState schedules exactly one rebuild. Two per
  // second would mean two live Timers. Without _timer.cancel() in dispose, the
  // Timer outlives [keeps running after] the widget and calls setState on a
  // State no longer mounted [attached to the tree], throwing
  // "setState() called after dispose()".

  @override
  Widget build(BuildContext context) {
    _builds++;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Session: $_seconds s', key: const Key('clock')),
        Text('Builds: $_builds', key: const Key('builds')),
        Probe(seconds: _seconds),
      ],
    );
  }
}

class Probe extends StatelessWidget {
  const Probe({super.key, required this.seconds});

  final int seconds;

  // Think: the Widget is cheap and thrown away â€” a fresh Probe object is built
  // every second, so its identityHashCode changes. The Element is kept: it
  // sits at one spot in the tree, holds the State, and its number never moves.
  // The third tree is the RenderObject, also long-lived [kept], created by the
  // Element; its job is the real layout and painting [measuring and drawing]
  // on the screen.

  @override
  Widget build(BuildContext context) {
    final bool above =
        context.findAncestorWidgetOfExactType<Scaffold>() != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Seen at: $seconds s', key: const Key('probe-seen')),
        Text(
          'Widget #${identityHashCode(this)}',
          key: const Key('probe-widget'),
        ),
        Text(
          'Element #${identityHashCode(context)}',
          key: const Key('probe-element'),
        ),
        Text(
          'Context belongs to: ${context.widget.runtimeType}',
          key: const Key('probe-context'),
        ),
        Text('Scaffold above me: $above', key: const Key('probe-above')),
      ],
    );
  }
}

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  // Think: this is composition â€” Tile wraps an ElevatedButton instead of
  // extending it. Flutter prefers it because inheritance [building by
  // subclassing] needs one new class per variation, which explodes; wrapping
  // small widgets combines freely, like Lego.

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Welcome, $studentName', key: const Key('welcome')),
    );
  }
}

class Tile extends StatefulWidget {
  const Tile(this.label, {super.key});

  final String label;

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  int taps = 0;

  @override
  Widget build(BuildContext context) => ElevatedButton(
    onPressed: () => setState(() => taps++),
    child: Text('${widget.label}: $taps'),
  );
}

class SwapBoard extends StatefulWidget {
  const SwapBoard({super.key});

  @override
  State<SwapBoard> createState() => _SwapBoardState();
}

class _SwapBoardState extends State<SwapBoard> {
  var tiles = [
    Tile(tileA, key: ValueKey(tileA)),
    Tile(tileB, key: ValueKey(tileB)),
    Tile(tileC, key: ValueKey(tileC)),
  ];

  void swap() => setState(() => tiles = tiles.reversed.toList());

  // Think: without keys Flutter matches children by type and position. The
  // widgets moved, but position 0 still held an Element of type Tile, so that
  // Element — and the State inside it, holding taps — was reused in place.
  // Only the label came from the new widget, so the count stayed on the left.
  // A ValueKey makes the Element follow its own widget instead of its slot.

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: tiles),
        ElevatedButton(
          key: const Key('swap'),
          onPressed: swap,
          child: const Text('Swap'),
        ),
      ],
    );
  }
}

class InfoPanel extends StatelessWidget {
  const InfoPanel({super.key});

  // Think: in a Column the main axis is vertical, so crossAxisAlignment acts
  // on the horizontal [left-right] axis — centre moves children sideways, not
  // up or down. mainAxisAlignment is what moves them vertically.

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          key: const Key('info-row'),
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Start: $startSec s', key: const Key('row-a')),
            Text('Tick: $tick s', key: const Key('row-b')),
            Text('Stop: $stopAt s', key: const Key('row-c')),
          ],
        ),
        const SizedBox(height: 12),
        Column(
          key: const Key('info-col'),
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Name: $studentName', key: const Key('col-a')),
            Text('Roll no: $rollNo', key: const Key('col-b')),
            Text('Course: $course', key: const Key('col-c')),
          ],
        ),
      ],
    );
  }
}

class ShareRow extends StatelessWidget {
  const ShareRow({super.key});

  // Think: swapped, the Exp button would keep its small natural size and the
  // Flex button would stretch to fill its share. Expanded is exactly
  // Flexible with fit: tight.

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key('share-row'),
      children: [
        SizedBox(
          key: const Key('fixed'),
          width: fixedW,
          child: ElevatedButton(onPressed: () {}, child: const Text('F')),
        ),
        Expanded(
          flex: flexA,
          child: ElevatedButton(
            key: const Key('exp'),
            onPressed: () {},
            child: const Text('Exp'),
          ),
        ),
        Flexible(
          flex: flexB,
          child: ElevatedButton(
            key: const Key('flex'),
            onPressed: () {},
            child: const Text('Flex'),
          ),
        ),
      ],
    );
  }
}

class InfoBox extends StatelessWidget {
  const InfoBox({super.key});

  // Think: padding is inside the border, margin outside it. Use a plain
  // Padding or SizedBox when you only need space and no paint [no colour,
  // border or rounded corners] — they are lighter than a Container.

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('info-box'),
      margin: EdgeInsets.all(boxMargin),
      padding: EdgeInsets.all(boxPad),
      decoration: BoxDecoration(
        color: swatches[hue]!.shade100,
        borderRadius: BorderRadius.circular(boxRadius),
        border: Border.all(width: boxBorder),
      ),
      child: Text('Course: $course', key: const Key('box-text')),
    );
  }
}

class StampStack extends StatelessWidget {
  const StampStack({super.key});

  // Think: a non-positioned child sizes the Stack — here the grey Container,
  // 300 x 120. If the Icons came first and the Container last, the Container
  // would still set the size but would paint on top, hiding both Icons.

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: const Key('stack'),
      children: [
        Container(
          key: const Key('layer-base'),
          width: 300,
          height: 120,
          color: Colors.grey.shade300,
        ),
        Positioned(
          top: dotTop,
          right: dotRight,
          child: const Icon(Icons.star, key: Key('dot-top')),
        ),
        Positioned(
          bottom: dotBottom,
          left: dotLeft,
          child: const Icon(Icons.circle, key: Key('dot-bottom')),
        ),
      ],
    );
  }
}
