# Assembly-Adventure
#### Copyright 2022 Adina-Maria Amzarescu
The final Univeristy project for the _Introduction to computer organization and assembly_ language course

This project has 4 tasks and 2 bonus tasks (64bit-assembly and special instruction cpuid).

`Task 1 - Album sort`

The main idea was to implement the **struct node* sort(int n, struct node* node)** function.
This function links the nodes in ascending order and returns the adress of the first node.
The structure of the array should not be moddified.

The structure:

    struct node {
        int val;
        struct node* next;
    };
    
Implementation:

 * The function has 2 while loops
    * while1: Finds the first node and saves it, 
      loops until there are no nodes left, 
      contains the second while
    * while2: Sorts the nodes and links them.
       The sorting is done by testing the values,
       the linking is done by storing in **[esi + ecx * 8 + 4]**
       the adress.

`Task 2 - Turing machine`

This task has 2 separate tasks. Tests 1-5 check _the first part_
and tests 6-10 _the second part_.

In this task I had to **only use the stack**. 

Task2 - first part

The program finds the least common multiple.
The main idea was to find the greatest common factor and then divide
the _a * b_ by it.

Task2 - second part

The program checks if a serie of brackets are balanced.
The idea was to cound in **ebx** how many **open** brackets there are
and in **ecx** how many **closed** brackets there are.

If the two registers store the same value, the brackets are balanced.

`Task 3 - Word sort`

Based on some given delimiters the program sorts the words using 
**qsort**.
At first the sorting will be made by the number of words and if
they are equal, the sorting will be made in lexicographical order.

The main 2 functions:

`void get_words(char *s, char **words, int number_of_words);`
   * receives the text (string array) in which the program saves
      the words that need to be sorted. 
      
`void sort(char **words, int number_of_words, int size);`
   * will sort the words. size = size of a word
   
   
Aux functions:

`compare_func`
    ->
`ft_strcmp`
`ft_strlen`
