# Assembly-Adventure
#### Copyright 2022 Adina-Maria Amzarescu
The final Univeristy project for the _Introduction to computer organization and assembly language_ course

This project has 4 tasks and 2 bonus tasks (64bit-assembly and special instruction cpuid).

______________________________________________________________________________________________________________

### `Task 1 - Album sort`

The main idea was to implement the **struct node* sort(int n, struct node* node)** function.
This function links the nodes in ascending order and returns the adress of the first node.
The structure of the array should not be modified.

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
      
______________________________________________________________________________________________________________

### `Task 2 - Turing machine`

This task has 2 separate tasks. Tests 1-5 check _the first part_
and tests 6-10 _the second part_.

In this task I had to **only use the stack**. 

* Task2 - first part

    The program finds the least common multiple.
    The main idea was to find the greatest common factor and then divide
    the _a * b_ by it.

* Task2 - second part

    The program checks if a series of brackets are balanced.
    The idea was to cound in **ebx** how many **open** brackets there are
    and in **ecx** how many **closed** brackets there are.

If the two registers store the same value, the brackets are balanced.

______________________________________________________________________________________________________________

### `Task 3 - Word sort`

Based on some given delimiters the program sorts the words using 
**qsort**.
At first the sorting will be made by the number of words and if
they are equal, the sorting will be made in lexicographical order.

The main 2 functions:

* `void get_words(char *s, char **words, int number_of_words);`
   * receives the text (string array) in which the program saves
      the words that need to be sorted. 
      
* `void sort(char **words, int number_of_words, int size);`
   * will sort the words. size = size of a word
   
   
Aux functions:

* `compare_func`
    * CheckS if the length of the two strings is different
    * CheckS the lexicographical order of the two strings s1 and s2
* `ft_strcmp`
* `ft_strlen`

______________________________________________________________________________________________________________

### `Task 4 - Bank accounts`

The program implements more recursive functions to find how much money there is in the bank account.

The 3 recursive functions that will have a value as a parameter:

* expression(char *p, int *i) - evaluates **term + term** or **term - term**
* term(char *p, int *i) -  evaluates **factor * factor** or **factor / factor**
* factor(char *p, int *i) - evaluates **(expression)** or **number** (digit array)

Details:

* p is the character array
* i is the current position
* the numbers are above 0 and whole, but after the operations they can be negative
* the divisions will be done on whole numbers
* the results are integers

______________________________________________________________________________________________________________

### `Bonus tasks`

1. Assembly 64bit
    
    This program interwines 2 arrays.
    
    Example:
    - v1 = 1 1 1 1
    - v2 = 2 2
    - interwine: 1 2 1 2 1 1

2. Special Instructions - CPUID
    
    CPUID is a special instruction that shows processor information.
    This function doesn't receive parameters, it is based on the
    **eax** register and, in some cases, **ecx**.
    
    Aux functions:
    * `features`
        It checks if _vmx_ is avalable, if _rdrand_ is set and if _avx_ is set.
    * `l2_cache_info`
        Sets eax to 0x80000006 and executes cpuid and gets the cache_size.
       
______________________________________________________________________________________________________________
