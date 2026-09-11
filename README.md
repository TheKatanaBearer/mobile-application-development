# CS 442 - Mobile Application Development
## Week 1 Lab Task: Enhanced Counter App

**Name:** Hamza Khan Tariq
**Roll Number:** 04072313050

---

## Personal Parameters
- **myThreshold:** 10 (sum of last 3 digits of roll number: 0+5+0 = 5, plus 5 = 10)
- **mySeedColor:** Colors.teal (first letter of last name that matches a Flutter color: Tariq → T → Teal)

---

## Screenshot

![App Screenshot](screenshot.png)

---

## Tasks Completed
- [x] Reset button added with Icons.refresh
- [x] Threshold message "You're on a roll!" appears when counter exceeds 10
- [x] Reset tracker displays how many times reset was pressed
- [x] Theme color changed to Colors.teal
- [x] About line added with name and roll number

---

## Reflection — What does setState() do?

Flutter builds the screen one time and then stops watching your variables. So when a variable like the counter changes, Flutter has no idea and the screen stays the same. setState() is how you tell Flutter that something changed and it needs to rebuild the screen. Without calling setState(), the variable updates in memory but nothing actually changes visually — the app looks frozen even though the value is different underneath.

---

*Built by Hamza Khan Tariq · 04072313050*
