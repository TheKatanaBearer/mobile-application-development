// library_lab.dart  -  Campus Library System
// Name: ____________________   Roll no: ____________

const String rollNo = '04072313050';   // e.g. '21F-0347'

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10;   // tens digit
final int u = seed % 10;    // units digit

const List<String> titles = [
  'Dart Basics', 'Flutter In Action', 'Data Structures', 'Operating Systems',
  'Mobile Design', 'Clean Code', 'Algorithms Unlocked', 'Computer Networks',
  'Database Systems', 'Software Testing',
];

int yearOf(int i) => 1995 + 2 * i + t;      // publication year of titles[i]
final int feePerDay = 5 + t;                // late fee per day, in rupees
final int daysLate = 3 + (t + u) % 6;       // normal number of days late
final int daysBig = 10 + u;                 // a long overdue period
final int feeCap = 150 + 10 * t;            // no single fee may exceed this
final int renewLimit = 1 + t % 3;           // renewals allowed per item
final int renewAttempts = 2 + u;            // renewal attempts made in Step 5
final int shelfSize = 3 + u % 4;            // items on the shelf in Steps 9-10
// ===========================================================================

//===============step 1 classes
abstract class LibraryItem {
  final String title;
  final int year;

  static int created = 0;

  LibraryItem(this.title, this.year) {
    created++;
  }

  static int capFee(int fee) => fee > feeCap ? feeCap : fee;

  String describe() => '$title ($year)';

  int lateFee(int days); // no body
}

abstract class Borrowable{
  bool get isAvailable;
  void borrow();
  void giveBack();
}


mixin Renewable {
  int renewals = 0;
  
  bool renew(int limit){
    if(renewals >= limit) return false;
      renewals++;
      return true;
  }
}

class Book extends LibraryItem with Renewable implements Borrowable{
  final int pages;
  bool _out = false;

  Book(super.title , super.year , this.pages);

  @override

  String describe() => '${super.describe()} , $pages pages';


  @override
  int lateFee(int days) => days * feePerDay;

  @override bool get isAvailable => !_out ; 

  @override
   void borrow() => _out = true;

   @override 

   void giveBack() => _out = false ; 




}

Book mainBook() => Book(titles[u] , yearOf(u), 100 + 3 * seed);

class Magazine extends LibraryItem{
  final int issue;

 Magazine(super.title , super.year , this.issue);

 @override

 String describe () => '${super.describe()} , Issue $issue';

 @override
 int lateFee(int days) => days * (feePerDay ~/ 2);
}

Magazine mainMagazine(){
  final i = ( u + 1 ) % 10;
  return Magazine(titles[i] , yearOf(i) , 1+ (t+u) % 12);

}

Dvd mainDvd(){
  final i = ( u + 2 ) % 10;
  return Dvd(titles[i] , yearOf(i) , 90 + seed % 40);

}

class Dvd extends LibraryItem with Renewable {
  final int minutes;

  Dvd(super.title , super.year , this.minutes);

  @override
  String describe () => '${super.describe()} , $minutes min ';

  @override
  int lateFee(int days) => days * feePerDay * 2;

}


enum MemberType{
  student(3,50),
  faculty(10,20),
  guest(1,0);

  final int maxLoans;
  final int discountPercent;
  const MemberType(this.maxLoans , this.discountPercent);

  int applyDiscount(int fee) => fee - (fee * discountPercent) ~/ 100;
}


extension MoneyText on int{
  String get rs => 'Rs $this';

}


extension Initials on String{
  String get initials => split(' ').map((w)=> w[0]).join();

}


extension ShelfMath on List<LibraryItem>{

  int totalLateFee(int days) => fold(0, ( sum , i ) => sum + i.lateFee(days));
}


class Fine {
  final int amount;
  const Fine(this.amount);

  Fine operator +(Fine o) => Fine(amount + o.amount);

  bool operator >(Fine o) => amount > o.amount;

  @override
  bool operator ==(Object other) => other is Fine && other.amount == amount;

  @override
  int get hashCode => amount.hashCode;

  @override
  String toString() => 'Fine($amount)';
}


List<LibraryItem> buildShelf() {
  final shelf = <LibraryItem>[];
  for (var k = 0; k < shelfSize; k++) {
    final i = (u + k) % 10;
    if (k % 3 == 0) {
      shelf.add(Book(titles[i], yearOf(i), 100 + 3 * seed));
    } else if (k % 3 == 1) {
      shelf.add(Magazine(titles[i], yearOf(i), 1 + (t + k) % 12));
    } else {
      shelf.add(Dvd(titles[i], yearOf(i), 90 + seed % 40));
    }
  }
  return shelf;
}

class Member {
  final String name;
  final MemberType type;

  Member(this.name, this.type);

  Fine feeFor(LibraryItem item, int days) {
    final fee = item.lateFee(days); // 1. raw fee
    final capped = LibraryItem.capFee(fee); // 2. cap it
    final discounted = type.applyDiscount(capped); // 3. member discount
    return Fine(discounted); // 4. as a Fine
  }
}




void main() {
  print('Seed: $seed (t=$t, u=$u)');
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

final b = mainBook();
LibraryItem item = b;
print('Step 1: Book: ${b.title}, Year: ${b.year}, Pages: ${b.pages}');
print('step 1: stored as LibraryItem: ${item.title}');
print('Step 1 : runtimeType = ${item.runtimeType}');

// think : item.pages is a compile error because dart checks the variable's
// declared type (LibraryItem) , and LibraryItem has no "pages" . The object 
// really is a book , but the compiler only trusts the type written on the
//variable 




}
void step2() { print('--- Step 2 ---');
print('step 2 : ${mainBook().describe()}');
print('step 2 : ${mainMagazine().describe()}');

// think : without @override and with the typo "describe()" , dart would
// quietly create a brand-new method instead of replacing the old one.
// calling describe() would then run the parents version , so the pages would be missing from the output
// and nothing would warn me


}
void step3() { print('--- Step 3 ---');

print('step 3: Book late fee for $daysLate days ='
      '${mainMagazine().lateFee(daysLate)}');
print('step 3: Dvd late fee for $daysLate days = '
      '${mainDvd().lateFee(daysLate)}');

// Think : LibraryItem( 'x' , 2000 ) gives "abstract classes cant be 
// instantiated" . An abstract class has a method (lateFee) with no body, so
// an object of it would have nothing to run . It exists only to be extended. 


 }
void step4() { print('--- Step 4 ---');

final book = mainBook();
print('step 4 : available? ${book.isAvailable}');
book.borrow();

print('step 4 : after borrow ? ${book.isAvailable}');
book.giveBack();
print('step 4: after return? ${book.isAvailable}');
final List<LibraryItem> items = [mainBook(), mainMagazine(), mainDvd()];

for(final item in items){
  print('step 4: ${item.runtimeType} borrowable? ${item is Borrowable}');


}


// Think : extends Borrowable would have copied any ready-made code 
// (fields and method bodies ) from Borrowable into Book for free. That is 
// not what I wanted : Borrowable is only  a promise with no code, and 
// implements forces Book to write its own isAvailable , borrow , giveBack.






 }
void step5() { print('--- Step 5 ---');

final book = mainBook();
var ok = 0;
for(var n =0; n< renewAttempts ; n++){
  if( book.renew(renewLimit)) ok++;
}

print('Step 5: renewed $ok of $renewAttempts attempts (limit $renewLimit)');
print('Step 5: renew once more? ${book.renew(renewLimit)}');
print('Step 5: dvd can renew too? ${mainDvd().renew(1)}');
  // Think: Book and Dvd need the same renew code but Magazine must not have
  // it. Putting renew in LibraryItem would hand it to Magazine too. A mixin
  // lets me share the code with only the classes I choose, sideways,
  // without changing the inheritance tree.




 }
void step6() { print('--- Step 6 ---');

final type = MemberType.values[seed % 3];

final fee = mainBook().lateFee(daysLate);

print('step 6: member type = ${type.name} (index ${type.index})');
print('step 6: max loans = ${type.maxLoans}');
print('step 6: book fee $fee -> ${type.applyDiscount(fee)} after discount');

// think : MemberType.student is checked  by the compiler, so a typo is an
// error straight away and the editor can autocompleted it. the string
// 'student' can be mistyped ('student') and only fail later, silently


 }
void step7() { print('--- Step 7 ---');

final type = MemberType.values[seed % 3];
final discounted = type.applyDiscount(mainBook().lateFee(daysLate));
final shelf = <LibraryItem>[mainBook() , mainMagazine() , mainDvd()];
print('Step 7: ${discounted.rs}');
print('step 7: initials of "${titles[u]}" = ${titles[u].initials}');
print('step 7: shelf fee for $daysLate days = '
      '${shelf.totalLateFee(daysLate).rs}');

// think: with 72.rs the behaviour reads like part of the int itself , shows
// up in complete 




 }
void step8() { print('--- Step 8 ---');

  final f1 = Fine(mainBook().lateFee(daysLate));
  final f2 = Fine(mainMagazine().lateFee(daysLate));
  print('Step 8: $f1 + $f2 = ${f1 + f2}');
  print('Step 8: first bigger? ${f1 > f2}');
  print('Step 8: equal copies? ${f1 == Fine(f1.amount)}');
  print('Step 8: set size = ${{f1, Fine(f1.amount), f2}.length}');
  // Think: without my hashCode the set size becomes 3, because Fine(x) and
  // its copy get different default hash codes and the set puts them in
  // different buckets before it ever calls ==. Equal objects must have equal
  // hash codes, so Dart expects == and hashCode to be written together.




 }
void step9() { print('--- Step 9 ---'); 
LibraryItem.created = 0;
  buildShelf();
  final shelf = buildShelf();
  print('Step 9: items created = ${LibraryItem.created}');
  print('Step 9: capped fee = '
      '${LibraryItem.capFee(shelf.first.lateFee(daysBig))} (cap $feeCap)');
  print('Step 9: const copies identical? '
      '${identical(const Fine(10), const Fine(10))}');
  print('Step 9: new copies identical? ${identical(Fine(10), Fine(10))}');
  // Think: a static member belongs to the class, not to any object, so
  // LibraryItem.created can be read before any object exists.


}
void step10() { print('--- Step 10 ---'); 

 final shelf = buildShelf();
  final member = Member('S$seed', MemberType.values[seed % 3]);
  final total = shelf.fold(
    Fine(0),
    (sum, item) => sum + member.feeFor(item, daysLate),
  );
  final borrowable = shelf.where((item) => item is Borrowable).length;
  final renewable = shelf.where((item) => item is Renewable).length;
  print('Step 10: ${shelf.length} items, $borrowable borrowable, '
      '$renewable renewable');
  print('Step 10: ${member.name} (${member.type.name}) owes $total');
  print('Step 10: over the cap? ${total > Fine(feeCap)}');



}
