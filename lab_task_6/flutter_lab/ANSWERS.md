Name: Hamza Khan Tariq
Roll no: 04072313050

A1: 14
A2: 11
A3: 3
A4: 10

B1: LabApp, HomePage, StudentCard and GoalBanner are Stateless because they only show data they were given and nothing inside them changes. Tally, Countdown and BuggyCounter are Stateful because each one holds a value that changes while the app runs: the count, the seconds left and the click count.

B2: The timer keeps running even after its widget is removed from the screen. If it is not cancelled in dispose() , till then setstate is called and memory is wasted and error will be there.

B3: Widgets with fixed values can be const, for example const Tally(), const Countdown(), const BuggyCounter(), const SizedBox and const Text('Reset'). The const allows flutter to build them once and reuse them instead of rebuilding them everytime.
