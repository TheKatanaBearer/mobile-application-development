final List<Map<String, dynamic>> books = [  
    {'title': 'Dart in Action', 'author': 'Ada', 'year': 2021,    'copies': 3, 'tags': ['dart', 'programming']},
    {'title': 'Flutter Basics', 'author': 'Sam', 'year': 2023,    'copies': 0, 'tags': ['flutter', 'mobile']},  
    {'title': 'Clean Code', 'author': 'Martin', 'year': 2008,    'copies': 2, 'tags': ['programming', 'design']},  
    {'title': 'Algorithms', 'author': 'Knuth', 'year': 1968,    'copies': 1, 'tags': ['programming', 'math']},  
    {'title': 'UI Design', 'author': 'Nora', 'year': 2019,    'copies': 4, 'tags': ['design', 'mobile']}, ]; 

// part 1: functions 

// task 1.1
double lateFee(int daysLate, double ratePerDay) => daysLate * ratePerDay;

// task 1.2

String formatTitle(String title , [String? author]){
    if(author == null){
        return title;
    }
    return '$title by $author';
}

// task 1.3
Map<String,dynamic> makeBook({
    required String title,
    required String author,
    int year =2024,
    int copies = 1,

}){
    return {
        'title': title,
        'author': author,
        'year': year,
        'copies': copies,
    };
}

// task 1.4
bool isClassic(int year)=> year < 2000;

//task 2.1
List <String> transformAll (List<String> items, String Function(String) fn){
    return items.map(fn).toList();
}

// task 2.2
int Function() makeCounter(){
    int count = 0;

    return (){
        count++;
        return count;
    };
}

// task 2.3
double Function(int) makeFeeCalculator(double rate){
    return (int days) => days * rate;
}

// task 2.4 (recursion)
int sumDigits(int n){
    if (n<10){
        return n;
    }

    return (n % 10) + sumDigits(n ~/10);
}

//task 3.4
Map<String,int> buildStock(){
    return{
        for (var b in books) b['title'] as String : b['copies'] as int,
    };
}

//task 4.1
class Box<T>{
    T value;
    Box(this.value);
}

// task 4.2
T firstOr<T>(List<T> items, T defaultValue){
    if (items.isEmpty){
        return defaultValue;
    }
    return items.first;
}  

// task 4.3 
class Pair<A,B>{
    final A first;
    final B second;
    Pair(this.first, this.second);

    @override
    String toString() => '($first, $second)';

}

// task 5.1
class BookNotFoundException implements Exception {
  final String title;
  BookNotFoundException(this.title);
}

class BookNotAvailableException implements Exception {
  final String title;
  BookNotAvailableException(this.title);
}

// task 5.2
void checkOut(Map<String, int> stock, String title) {
  if (!stock.containsKey(title)) {
    throw BookNotFoundException(title);
  }
  if (stock[title]! <= 0) {
    throw BookNotAvailableException(title);
  }
  stock[title] = stock[title]! - 1;
}

// task 5.4
Map<String, dynamic> findBook(String title) {
  return books.firstWhere((b) => b['title'] == title);
}

// task 6.1
Future<String> fetchBookOfTheDay() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Dart in Action';
}

// task 6.3
Future<String> fetchBroken() async {
  await Future.delayed(Duration(milliseconds: 500));
  throw Exception('Server down');
}

void main() async {  
    part1();  
    part2(); 
    part3(); 
    part4();  
    part5();  
    await part6(); 
    }  
void part1() { 
    print('--- Part 1 ---'); 
    print('Late fee: ${lateFee(5, 0.5)}');
    print(formatTitle('Dart in Action'));
    print(formatTitle('Dart in Action', 'Ada'));
    print(makeBook(title: 'Clean Code', author: 'Martin'));
    print(makeBook(title: 'Algorithms', author: 'Knuth', year: 1968));
    print(isClassic(1968));
    print(isClassic(2021));} 
void part2() {
    print('--- Part 2 ---');
    var titles = ['Dart in Action', 'Clean Code'];
    print(transformAll(titles, (s) {
        return s.toUpperCase();
  }));
    print(transformAll(titles, (s) => '$s!'));

    
    var desk1 = makeCounter();
    var desk2 = makeCounter();
    print(desk1());
    print(desk1());
    print(desk1());
    print(desk2());

    var studentFee = makeFeeCalculator(0.25);
    var staffFee = makeFeeCalculator(0.10);
    print('Student fee: ${studentFee(4)}');
    print('Staff fee: ${staffFee(4)}');

    print('Sum of digits: ${sumDigits(2024)}'); }
    void part3() { print('--- Part 3 ---');
    // 3.1
    var titles=books.map((b)=>b['title'] as String).toList();
    print('Titles: $titles');

    var available = books
    .where((b)=>(b['copies'] as int ) >= 1)
    .map((b)=>b['title'] as String)
    .toList();

    print ('Available: $available');

    // 3.2
    var totalCopies = books.fold(0 , (sum,b) => sum +(b['copies'] as int));
    print ('Total copies: $totalCopies');

    var years = books.map((b)=>b['year'] as int ).toList();
    var oldest = years.reduce((a,b)=> a<b ? a:b);
    print('Oldest year: $oldest');
    
    

     // 3.3
     var sorted = List.of(books);
     sorted.sort((a,b) => (a['year'] as int).compareTo(b['year'] as int));
     print('By year: ${sorted.map((b) => b['title']).toList()}');

     // 3.4
     var stock = buildStock();
     print('Stock: $stock');

     stock.forEach((title,copies){
        if (copies == 0) print('Out of stock: $title');
     });

     print('Copies of Unknown: ${stock['Unknown'] ?? 0}');

    
 


     // 3.5
    var allTags ={
        for(var book in books) ...(book['tags'] as List),

    };

    print ('All tags: $allTags');
    var listA = {'Dart in Action', 'Clean Code', 'Flutter Basics'};
    var listB = {'Clean Code', 'Flutter Basics', 'Algorithms'};
    print('Union: ${listA.union(listB)}');
    print('Common: ${listA.intersection(listB)}');
    print('Only in A: ${listA.difference(listB)}');
    }
    void part4() { print('--- Part 4 ---'); 
    
    var intBox = Box<int>(5);
    var strBox = Box<String>('dart');
    print('Box<int>: ${intBox.value}');
    print('Box<String>: ${strBox.value}');


    print(firstOr(['Dart in Action' , 'Clean Code'] , 'none'));
    print(firstOr<String>([],'z'));

    print(Pair('Dart in Action', 3));

    
    }
    void part5() { print('--- Part 5 ---'); 
    // 5.3
  var stock = buildStock();

  for (var title in ['Dart in Action', 'Flutter Basics', 'Unknown Book']) {
    try {
      checkOut(stock, title);
      print('Checked out: $title');
    } on BookNotFoundException catch (e) {
      print('Not found: "${e.title}"');
    } on BookNotAvailableException catch (e) {
      print('Sorry: "${e.title}" has no copies left');
    } finally {
      print('Transaction logged.');
    }
  }

  print('Copies left of Dart in Action: ${stock['Dart in Action']}');

  // 5.4
  try {
    findBook('Missing');
  } on StateError {
    print('Search failed: no such book');
  }
    }
    Future<void> part6() async { print('--- Part 6 ---'); 
    // 6.1
  print('Fetching...');
  var book = await fetchBookOfTheDay();
  print('Book of the day: $book');

  // 6.2: uncomment these two lines once to see what happens without await,
  // then comment them out again
  // var oops = fetchBookOfTheDay();
  // print(oops);   // prints: Instance of '_Future<String>'

  // 6.3
  try {
    await fetchBroken();
  } catch (e) {
    print('Fetch failed: $e');
  }
    } 