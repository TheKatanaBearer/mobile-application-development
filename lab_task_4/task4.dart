// cafe safe order system
// Hamza khan tariq 04072313050
const String rollNo='04072313050';


// seed settings
final int seed = int.parse(rollNo.substring(rollNo.length-2));

final int t = seed ~/10;    // tens digits
final int u = seed % 10;    // units digits

const List<String> menu = [
    'Chai' , 'Latte' , 'Mocha' , 'Samosa' , 'Brownie' , 'Sandwich',
    'Cold Coffee' , 'Fries' , 'Pakora' , 'Zinger Wrap',
];

int priceOf(int i)=> 100 + 7 * i + 3 * t;
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

  MenuItem(this.name, this.price) {   // long way
   if(this.price < priceFloor){
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
  price =int.parse(text.split(':')[1]);



}

class OrderLog{
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


class OrderLine{
    final MenuItem item;
    final int qty;
    final int total;
    final int tax;

    OrderLine(this.item, this.qty)
    : total = item.price * qty,
    tax = item.price * qty * taxPercent ~/ 100,
    assert(qty > 0 , 'qty must be positive');
    // Think (Step 5): an initializer list cannot read another field of the
    // same object (like total) because the object is not built yet while
    // the list runs. So tax is recomputed from item and qty instead.
}

OrderLine mainOrder(){
    return OrderLine(MenuItem(menu[u], priceOf(u)), 2 + (t+u) % 5);
}


void main(){
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

void step1() { print('--- Step 1 ---'); 
 var item1 = Dish();
 item1.name = menu[u];
 item1.price = priceOf(u);

 var item2 = Dish();
 item2.name = menu[(u+1) % 10];
 item2.price = priceOf((u+1) % 10);
 item2.price = item2.price - u;


  print('Step 1: ${item1.name} Rs ${item1.price}');
  print('Step 1: ${item2.name} Rs ${item2.price}');

}


void step2() { print('--- Step 2 ---');

var a = MenuItem(menu[u] , priceOf(u));
var b = MenuItem('Test special' , 15*u);

print('step 2: ${a.name} Rs ${a.price}');
print('step 2: Test special Rs ${b.price}');




 }
void step3() { print('--- Step 3 ---'); 
var freebie = MenuItem.free('Water');

int i = ( u + 2) % 10;

var parsed = MenuItem.fromString('${menu[i]}:${priceOf(i)}');

print('Step 3: ${freebie.name} Rs ${freebie.price}');
print('Step 3: ${parsed.name} Rs ${parsed.price}');
print('Step 3: floor=$priceFloor , free price = ${freebie.price} ');

}
void step4() { print('--- Step 4 ---');

var log1 = OrderLog();
var log2 = OrderLog();

for(int i = 1; i<=u+2; i++){
    String msg = 'order #${100 * t + i}';
    if(i % 2 == 1){
        log1.add(msg);  // odd i
    }

    else{
        log2.add(msg);  // even i
    }
}

print('Step 4 : same object? ${identical(log1, log2)}');
print('Step 4: entries = ${log1.entries.length}');
print('Step 4: last = ${log2.entries.length}');

 }
void step5() { print('--- Step 5 ---');
  var line = mainOrder();
  print('Step 5: ${line.item.name} x${line.qty}');
  print('Step 5: total=${line.total} tax=${line.tax}');

  try {
    OrderLine(line.item, 0);          // qty 0 should set off the alarm
    print('Step 5: assert did NOT fire');
  } on AssertionError {
    print('Step 5: assert fired');
  }
 
 }
 
void step6() { print('--- Step 6 ---'); }
void step7() { print('--- Step 7 ---'); }
void step8() { print('--- Step 8 ---'); }
void step9() { print('--- Step 9 ---'); }
void step10() { print('--- Step 10 ---'); }



