# Layout and lifecycle: Team Board lab

Hamza Khan Tariq — 04072313050 (seed 50, t = 5, u = 0)

A1: 9
A2: 5
A3: 4
A4: 75

## B1: Stateless and Stateful

Stateless: LabApp, HomePage, SettingsCard, SummaryRow, Welcome, Probe,
InfoPanel, ShareRow, InfoBox, StampStack. Each only describes a fixed layout
built from values that never change inside it, so a new widget object every
rebuild costs nothing and nothing has to be remembered.

Stateful: Clock, Tile and SwapBoard. Clock has to remember the running second
count and the number of builds, and it owns a Timer that must be started once
and cancelled once. Tile remembers its own tap count. SwapBoard holds the order
of the tiles and reverses it. Anything that has to survive a rebuild has to
live in a State object, which is why these three are StatefulWidgets.

## B2: Widget, Element, RenderObject

The Widget is rebuilt on every setState; the Element and the RenderObject are
kept. Probe showed this directly: every second the Widget number changed while
the Element number stayed identical, because a fresh Probe widget object was
built on each tick but the Element sitting at that spot in the tree was reused
rather than recreated.

That matters because the Element is what holds the State. It is why a Tile
keeps its tap count across rebuilds, and why in Step 5 the count stayed on the
left tile without keys — the Element stayed in its slot and kept its State
while only the label changed. Probe also printed "Context belongs to: Probe",
confirming that the BuildContext passed into build is that Element, the
widget's own address in the tree, and "Scaffold above me: true", because
findAncestorWidgetOfExactType walked up from that address and found the
Scaffold in HomePage.

The RenderObject is the third tree, also long-lived. It does the actual
measuring and painting on the screen.

## B3: Constraints go down, sizes go up

The parent passes constraints down and the child sends its chosen size back up,
then the parent decides where to put it.

In Step 7 the three bare Texts inside the Row each received an unbounded width
constraint, so each asked for one long unbroken line. The three requested
widths added up to more than the Row had, and Flutter painted the yellow-black
overflow stripes. Wrapping each Text in Expanded changed what went down: each
child was now given a tight maximum width of one third of the Row. Having a
bounded maximum, each Text had to fit it and so wrapped its words onto several
lines, and the size reported back up fitted the Row exactly.

The Text widget itself was never modified. Only the constraint handed to it
changed, and the layout followed from that.
