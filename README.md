# Binary-Game
Description

An educational game built in MIPS Assembly. It quizzes the user on converting from Binary to Decimal numbers and vice versa, progressively getting harder across the 10 levels.

Features

- 10 levels that keep getting harder testing conversions between binary and decimal
- A modular MIPS Assembly structure where files each focus on a seperate task like display, logic, question generator, answer validation, etc
- Input validation for answers, allowing users to repeatedly try again if answer is wrong
- Randomized question generator
- Clean terminal based board using Mars Syscall functions

How it Works

The game generates a number in either binary or decimal, prompting the user to convert to the other format. 
- Each level has the same amount of questions as the level number and once you have answered all the questions for a level, you move on to the next level
- If player gets a question wrong, they are prompted so and allowed to keep trying until they get it right
- Once the players has finished level 10 they have completed the game

File Structure

BinaryGame/
│── README.md
│── Syscalls.asm
│── main.asm
│── gameMain.asm
│── drawBoard.asm
│── generateProblem.asm
│── getUserInput.asm
│── validateAnswer.asm
│── convertBinaryToDecimal.asm
│── convertDecimalToBinary.asm

Technologies

- MIPS Assembly Language
- MARS Simulator (MIPS Assembler and Runtime)

Concepts Used

- Register Level Computation
- Memory operations and addressing
- Branching and Control Flow Logic
- Syscalls Input and Output
- A modular Assembly Design
- Binary-Decimal conversion algorithms

How to Run

1. Download all the .asm files into a single folder
2. Open the project in MARS
3. Load the main.asm file
4. Assemble and run the program

Future Improvements

- Add difficulty modes like easy, medium, hard
- Add a help me section where information to convert between decimal and binary numbers is shown
- Display a game score that could go up or down depending on how many questions in a row you get right
- Add sounds for when you get question correct or incorrect
- Add a timed mode
