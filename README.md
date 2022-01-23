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
    * while2: sorts the nodes and links them.
       The sorting is done by testing the values,
       the linking is done by storing in **[esi + ecx * 8 + 4]**
       the adress.
         
