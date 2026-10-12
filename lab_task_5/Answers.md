@'
# OOP Lab: Campus Library System

Name: Hamza Khan Tariq
Roll no: 04072313050

**Q1. What can a subclass using `extends` use for free that a class using `implements` has to write itself?**
A subclass using `extends` inherits the parent's fields and method bodies and can use them as they are, while a class using `implements` only gets the names and signatures and must write every member itself.

**Q2. `Book` and `Dvd` both use `Renewable`. When would you pick a mixin, and when an abstract parent class?**
I pick a mixin to share ready-made code with some unrelated classes (Book and Dvd but not Magazine), and an abstract parent class when the classes are a real "is-a" family that share state and must all write the same required methods, like `lateFee`.

**Q3. Why must you override `hashCode` whenever you override `==`?**
Sets and maps use `hashCode` first to find a bucket and only then call `==`, so equal objects must have the same hash code, otherwise equal values land in different buckets and are treated as different.

**Q4. An extension method on `String` and a subclass of `String` both add behaviour. Why does Dart let you write the first one but not the second?**
An extension just adds methods that are resolved at compile time without creating a new type, whereas `String` is a final class that cannot be subclassed.
'@ | Set-Content -Path lab_task_5\ANSWERS.md -Encoding utf8