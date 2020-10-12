Sudoku Solver
============================================


*Author: Andrea Zubenko 

This project is a sudoku solver that implements a simple backtracking algorithm.
It reads a file containing the sudoku to solve, then runs the algorithm on it and outputs the solution on both StdOut and in an output file.

## Conventions used in the project 

- Functions, each declared in its own file, are named in camelCase (both filename and global label)

- Macros, organized in four small libraries, are named in lowercase, with underscores to separate words (e.g. new_macro). Libraries all start with "m_" (e.g. "m_file")

- Constants (.eqv) are named in UPPERCASE 

- Labels (e.g. main:, while: etc.) are named in camelCase

- Line wrap is fixed at 120 characters

- Cells in the matrix are identified by the standard notation matrix[row][col]

- Example input files have a name that starts with "sudoku" and have .txt extension (e.g. sudoku_semplice.txt, which means sudoku_easy). semplice/medio/difficile translate to easy/medium/hard.

## Input file

A input file, to be valid, has to contain 81 or more digits (if there are more, only the first 81 will be used). Digits can be separated with any character (including whitespace, or no characters at all).
Zero is used to represent an empy cell in the sudoku grid, and the file must be in ASCII format.

The program is to be executed with [MARS](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwjdicDQia_sAhUMTcAKHXe7D9MQFjAQegQIBBAC&url=https%3A%2F%2Fwww.d.umn.edu%2F~gshute%2Fmips%2FMars%2FMars.xhtml&usg=AOvVaw2TbYIiXtqOSsVWMMK7psyk), with the "assemble all files in directory" option checked. The jar must be in the same directory of the other files.

After starting the program (via the main.asm file), the user'll be asked to specify a filename. If no name is given, "sudoku".txt will be used instead.

## Output file

The solved sudoku (if solvable) will be saved in a file specified by the user. If no name is given, "soluzione.txt" will be used instead.

## Code example

```
Inserire il nome del file di output (default:"soluzione.txt"): Inserire il nome del file di input (default:"sudoku.txt"): sudoku_difficile.txt

### Griglia iniziale ###

----------------------
|. . 4 |8 6 . |. 3 . |
|. . 1 |. . . |. 9 . |
|8 . . |. . 9 |. 6 . |
----------------------
|5 . . |2 . 6 |. . 1 |
|. 2 7 |. . 1 |. . . |
|. . . |. 4 3 |. . 6 |
----------------------
|. 5 . |. . . |. . . |
|. . 9 |. . . |4 . . |
|. . . |4 . . |. 1 5 |
----------------------

### SOLUZIONE ###

----------------------
|9 7 4 |8 6 5 |1 3 2 |
|2 6 1 |3 7 4 |5 9 8 |
|8 3 5 |1 2 9 |7 6 4 |
----------------------
|5 4 3 |2 9 6 |8 7 1 |
|6 2 7 |5 8 1 |3 4 9 |
|1 9 8 |7 4 3 |2 5 6 |
----------------------
|4 5 2 |9 1 7 |6 8 3 |
|3 1 9 |6 5 8 |4 2 7 |
|7 8 6 |4 3 2 |9 1 5 |
----------------------
Inserire il nome del file di output (default:"soluzione.txt"): 

```


***

*Autore:     Andrea Zubenko (Matricola 908857)*

Il progetto consiste in un risolutore sudoku che implementa un semplice algoritmo di backtracking.
Dopo aver letto un file di testo contenente il sudoku da risolvere, il programma stampa a schermo la soluzione e la salva in un file di output.


## Convenzioni usate nel progetto

- Le funzioni, ognuna dichiarata nel proprio file, sono chiamate in camelCase, sia come nome del file che come label globale

- Le macro, organizzate in 4 piccole librerie, sono chiamate in lowercase, e underscore per separare le parole (es. nuova_macro). Le librerie delle macro cominciano con "m_" (es. "m_file")

- Le costanti (.eqv) sono chiamate in UPPERCASE

- Le label (main:, while: ecc.) sono chiamate in camelCase

- Line wrap fissata a 120 caratteri 

- Per identificare una cella all'interno di una matrice, si usa la notazione standard matrix[row][col]

- I file di input di esempio sono hanno un nome che inizia per sudoku, e hanno estensione .txt (es. sudoku_semplice.txt)

## File di input

Un file di input, per essere valido, deve contenere 81 o piu cifre (se sono di piu, verrano utilizzate solo le prime 81). Le cifre possono essere attaccate o separate con qualsiasi carattere.
Per rappresentare una posizione vuota, si usa la cifra 0.
La codifica deve essere ASCII.

Per ragione tecniche di MARS, **i file devono essere nella stessa cartella del .jar** 

All'avvio del programma, verrà chiesto il nome del file da usare. Nel caso non si immetta alcun input (ovvero si prema subito invio), verrà usato il file di default "sudoku.txt"

## File di output 

Il sudoku risolto, se risolvibile, sarà salvato in un file, con nome deciso dall'utente (default: "soluzione.txt")


Si tenga conto che ci vuole del tempo per risolvere il sudoku, a seconda della difficoltà dello stesso.



