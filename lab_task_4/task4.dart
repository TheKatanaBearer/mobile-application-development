// cafe safe order system
// Hamza khan tariq 04072313050
const String rollNo = '04072313050';

// seed settings
final int seed = int.parse(rollNo.substring(rollNo.length - 2));

final int t = seed ~/ 10;
final int u = seed % 10;

const List<String> menu = [
  'Chai',
  'Latte',
  'Mocha',
  'Samosa',
  'Brownie',
  'Sandwich',
  'Cold Coffee',
  'Fries',
  'Pakora',
  'Zinger Wrap',
];

int priceOf(int i) => 100 + 7 * i + 3 * t;
final int priceFloor = 60 + 5 * t;
final int taxPercent = 5 + t;
final int bigOrderLimit = 450 + 20 * t;
final int balanceCap = 600 + 20 * t;
final int couponPercent = 5 + t + u;
//========================================================

class Dish {
  late String name;
  late int price;
}

class MenuItem {
  String name;
  int price;

  MenuItem(this.name, this.price) {
    // long way
    if (this.price < priceFloor) {
      this.price = priceFloor;
    }
  }

  // Think (Step 2): price cannot be final because the constructor body
  // changes it after the object is created (raises it to priceFloor),
  // and a final field can only be assigned once.

  MenuItem.free(this.name) : price = 0;

  // Think (Step 3): the floor logic did not run for free() because it lives
  // in the main constructor's body. A named constructor is a separate
  // constructor and does not run that body.

  MenuItem.fromString(String text)
    : name = text.split(':')[0],
      price = int.parse(text.split(':')[1]);

  @override
  String toString() => '$name (Rs $price)';
}

class OrderLog {
  static OrderLog? _instance;
  final List<String> entries = [];

  OrderLog._internal();

  factory OrderLog() {
    _instance ??= OrderLog._internal();
    return _instance!;
  }

  void add(String msg) => entries.add(msg);
  // Think (Step 4): the underscore makes _instance and _internal private
  // to the file. Without it, other code could replace _instance or call
  // the constructor directly and create a second log, breaking the
  // "one shared log" idea.
}

class OrderLine {
  final MenuItem item;
  final int qty;
  final int total;
  final int tax;

  OrderLine(this.item, this.qty)
    : total = item.price * qty,
      tax = item.price * qty * taxPercent ~/ 100,
      assert(qty > 0, 'qty must be positive');
  // Think (Step 5): an initializer list cannot read another field of the
  // same object (like total) because the object is not built yet while
  // the list runs. So tax is recomputed from item and qty instead.

  int get grand => total + tax;

  bool get isBigOrder => grand > bigOrderLimit;

  String get label => '${item.name} x$qty';

  // Think (Step 6): line.grand = 5 fails because grand is a getter only,
  // so it can be read but not assigned. To make it legal I would have to
  // add a setter: set grand(int v) { ... }
}

OrderLine mainOrder() {
  return OrderLine(MenuItem(menu[u], priceOf(u)), 2 + (t + u) % 5);
}

class StudentCard {
  final String owner;
  int _balance;

  StudentCard(this.owner) : _balance = 0;

  int get balance => _balance;

  set balance(int v) {
    if (v < 0) {
      _balance = 0;
    } else if (v > balanceCap) {
      _balance = balanceCap;
    } else {
      _balance = v;
    }
  }

  // Think (Step 7): another thing a setter could do with an invalid value
  // is throw an error (e.g. ArgumentError) so the caller knows it was
  // wrong, instead of silently fixing it.
}

List<MenuItem> buildMenu() {
  return [
    for (int k = 0; k < 4; k++)
      MenuItem.fromString(
        '${menu[(u + 3 * k) % 10]}:${priceOf((u + 3 * k) % 10)}',
      ),
  ];
}

List<OrderLine> buildReceipt() {
  var items = buildMenu().take(3).toList();
  return [for (int k = 0; k < 3; k++) OrderLine(items[k], 1 + (t + k) % 4)];
}

class Coupon {
  static final Map<String, Coupon> _cache = {};

  final String code;
  final int percent;
  final int minSpend;

  Coupon(this.code, this.percent)
    : minSpend = percent * 70,
      assert(percent >= 1 && percent <= 50);

  factory Coupon.fromCode(String code) {
    return _cache.putIfAbsent(code, () => Coupon(code, couponPercent));
  }

  int discountOn(int amount) {
    if (amount >= minSpend) {
      return amount * percent ~/ 100;
    }
    return 0;
  }
}

void main() {
  print('Seed: $seed (t=$t, u =$u)');
  step1();
  step2();
  step3();
  step4();
  step5();
  step6();
  step7();
  step8();
  step9();
  step10();
}

void step1() {
  print('--- Step 1 ---');
  var item1 = Dish();
  item1.name = menu[u];
  item1.price = priceOf(u);

  var item2 = Dish();
  item2.name = menu[(u + 1) % 10];
  item2.price = priceOf((u + 1) % 10);
  item2.price = item2.price - u;

  print('Step 1: ${item1.name} Rs ${item1.price}');
  print('Step 1: ${item2.name} Rs ${item2.price}');
}

void step2() {
  print('--- Step 2 ---');

  var a = MenuItem(menu[u], priceOf(u));
  var b = MenuItem('Test special', 15 * u);

  print('step 2: ${a.name} Rs ${a.price}');
  print('step 2: Test special Rs ${b.price}');
}

void step3() {
  print('--- Step 3 ---');
  var freebie = MenuItem.free('Water');

  int i = (u + 2) % 10;

  var parsed = MenuItem.fromString('${menu[i]}:${priceOf(i)}');

  print('Step 3: ${freebie.name} Rs ${freebie.price}');
  print('Step 3: ${parsed.name} Rs ${parsed.price}');
  print('Step 3: floor=$priceFloor , free price = ${freebie.price} ');
}

void step4() {
  print('--- Step 4 ---');

  var log1 = OrderLog();
  var log2 = OrderLog();

  for (int i = 1; i <= u + 2; i++) {
    String msg = 'order #${100 * t + i}';
    if (i % 2 == 1) {
      log1.add(msg);
    } else {
      log2.add(msg);
    }
  }

  print('Step 4 : same object? ${identical(log1, log2)}');
  print('Step 4: entries = ${log1.entries.length}');
  print('Step 4: last = ${log2.entries.length}');
}

void step5() {
  print('--- Step 5 ---');
  var line = mainOrder();
  print('Step 5: ${line.item.name} x${line.qty}');
  print('Step 5: total=${line.total} tax=${line.tax}');

  try {
    OrderLine(line.item, 0);
    print('Step 5: assert did NOT fire');
  } on AssertionError {
    print('Step 5: assert fired');
  }
}

void step6() {
  print('--- Step 6 ---');
  var line = mainOrder();

  print('Step 6: grand=${line.grand}');
  print('Step 6: big order? ${line.isBigOrder} (limit $bigOrderLimit)');
  print('Step 6: label=${line.label}');
}

void step7() {
  print('--- Step 7 ---');

  var card = StudentCard('S$seed');

  card.balance = seed * 10 + 50;
  print('Step 7: topped up = ${card.balance}');

  card.balance = -seed - 1;
  print('Step 7: bad value = ${card.balance}');

  card.balance = balanceCap - u;
  print('Step 7: reset = ${card.balance}');

  card.balance = card.balance - mainOrder().grand;
  print('Step 7: paid order = ${card.balance}');
}

void step8() {
  print('--- Step 8 ---');
  var items = buildMenu();

  var priciest = items.reduce((a, b) => a.price >= b.price ? a : b);
  int sum = items.fold(0, (total, item) => total + item.price);

  print('Step 8: menu = $items');
  print('Step 8: priciest = ${priciest.name}');
  print('Step 8: sum = $sum');
}

void step9() {
  print('--- Step 9 ---');

  var receipt = buildReceipt();
  int sum = 0;

  for (var line in receipt) {
    print('Step 9: ${line.label} = ${line.grand}');
    OrderLog().add('receipt: ${line.label}');
    sum += line.grand;
  }

  print('Step 9: receipt total = $sum');
  print('Step 9: log size = ${OrderLog().entries.length}');
}

void step10() {
  print('--- Step 10 ---');

  String code = 'CAFE${seed.toString().padLeft(2, '0')}';

  var c1 = Coupon.fromCode(code);
  var c2 = Coupon.fromCode(code);

  int receipt = 0;
  for (var line in buildReceipt()) {
    receipt += line.grand;
  }

  int discount = c1.discountOn(receipt);

  print('Step 10: $code gives ${c1.percent}% off, min spend ${c1.minSpend}');
  print('Step 10: cached? ${identical(c1, c2)}');
  print(
    'Step 10: receipt $receipt, discount $discount, payable ${receipt - discount}',
  );
}


//Q1: The shorthand menuitem prevents me from writing the parameter name twice and assigning each field manually. the lesser the code the less the chance of any error

//Q2: by using named constructor i gave the class the ability to create objct in many ways...i use factory when i need to return an existing object

//Q3: as the constructor body already exists , thus the field is assigned after creation...in the initlizer list the field is assigned before the constructor body runs, which is the only way to set final fields from computed values

//Q4: a getter is useful when a value can be computed from other fields , so it never goes out of date . A setter is useful instead of a public field because it can check or fix a value before storing it.