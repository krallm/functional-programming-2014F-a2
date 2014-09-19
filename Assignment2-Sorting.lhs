Functional Programming
Fall 2014, Schrum
Assignment 2: Sorting

Sorting is a fundamental concept in Computer Science. Many different sorting algorithms exist, and you have already been exposed to several in previous classes. However, the details of how many of these algorithms function is different in a pure functional language like Haskell. You have already seen an example of quick sort on pages 7-8. This assignment will make you think about some of these differences while implementing several sorting algorithms in Haskell. If you properly apply the functional programming mindset, you should find that your code in Haskell is more concise and easier to understand than the corresponding algorithms in Java. Here is a list of the learning objectives for this assignment:

1. Understand the fundamental concepts behind several sorting algorithms, rather than simply thinking of a particular sorting algorithm as a specific arrangement of code.
2. Understand what it means for an algorithm to be an "in-place" algorithm, and how this concept relates to functional programming.
3. Understand some of the restrictions in a functional language like Haskell, and learn techniques for working around these restrictions.
4. Get comfortable working with lists and recursion.
5. Think about how some of the restrictions of Haskell could actually help you write clearer code in an imperative language like Java.
6. Get practice explaining your code while writing in the literate programming style.
7. Write some functions that do testing of your code to make sure it works.
8. Discuss concepts and code in groups to gain a better understanding of how to write clear, concise Haskell code.

This assignment involves both in-class and out-of-class portions. We will start by discussing the questions below in class. If you get through the questions quickly, then you can work on the code in class, but this section of the assignment is mostly intended to be accomplished outside of class. You will work in pairs for this assignment. This will be your group both in class and outside of class. In the end, you will turn in one file per group. The file you turn in will be this file, renamed as follows: List the last name of each group member, followed by the assignment number and the "lhs" extension. For example, if I were working with Dr. Anthony on this assignment, we would turn in one file named "AnthonySchrum#2.lhs" via Moodle. You should also fill out the following entries to make sure I have all appropriate information about all group members:

Group Member #1:
Name: [TODO]
E-Mail: [TODO]
Phone: [TODO]

Group Member #2:
Name: [TODO]
E-Mail: [TODO]
Phone: [TODO]

All instances of TODO that appear below need to be filled in by your group. All group members should understand and be able to answer all questions, and be able to re-create all code. There will be an in-class quiz after the assignment due date that tests each individual's knowledge of the material learned while doing the assignment. You may only share your code with me, departmental tutors, and your group members. You may talk about your code, and the answers to the questions with anyone in the class, with me, and with departmental tutors. You may not discuss any part of this assignment with students outside of this class, and you may not look up any information online. You can use the textbook as a reference tool.

CODE WARNING: Some of the algorithms below can be written in very elegant fashion using built-in functions that are pre-defined in Haskell. You are NOT allowed to use any of these functions. The purpose of this assignment is for you to learn how to define your own functions from scratch, so if you need a helper function, you have to write it yourself. All of these algorithms can be written using the basic language features of Haskell with a few helper functions. The only built-in functions that you can use are simple low-level functions that we have seen in class and in the sections of the book we have read so far (don't use advanced functions from later chapters). In fact, the only named functions I needed were "div" and "length".

CODE WARNING: All code must be written in the literate programming style. Fully explain your code in complete sentences before presenting it, so I can appreciate the thought process behind your code. If your code doesn't work at all or has bugs, then talk about them in the literate comments preceding your code so that I know. Note that I won't be able to load and run your assignment if there is incomplete or broken code, so remove the starting '>' symbols from broken code and explain these omissions in the literate comments.

----------------------------------------------------------------

1.1. List all of the sorting algorithms you know. What do you know about these algorithms? Which are faster?

[DONE]

Merge sort - Fast in general.
Quick sort - Fast in general.
Selection sort - Inefficient with larger lists.
Insertion sort - Efficient for small / mostly sorted lists.
Bubble sort

1.2. What is an "in-place" algorithm? What does "in-place" mean in the context of sorting algorithms? Which of the algorithms you listed in the previous question are "in-place"? Does it even make sense to ask this question? (You may look up the definition of "in-place" sorting if necessary.)

[DONE]

The algorithm can just modify the existing list without creating/returning a new one.
Merge sort, quick sort, and insertion sort can be implemented with in-place algorithms.

1.3. Is it possible to write an "in-place" algorithm in Haskell? Why/why not? Give separate answers for both sorting algorithms specifically, and algorithms in general.

[DONE]

For sorting algorithms, possibly, but it may not be a good idea or allow for efficient implementations.
For algorithms in general, something like appending to a list (if that counts as an in-place algorithm).

----------------------------------------------------------------

2.1. What is "insertion sort"? Why is it called "insertion sort"?

[DONE]

The algorithm basically inserts each element into an empty array/list, while keeping that
array/list sorted while it adds to it.

Look at this code for insertion sort in Java and convince yourself that it is correct. Then answer the following questions.

public static void insertionSort(int[] array) {
  for(int i = 1; i < array.length; i++) {
    for(int j = i - 1; j >= 0 && array[j+1] < array[j]; j--) {
      swap(array,j,j + 1); 
    }
  }
}

public static void swap(int[] array, int p1, int p2) {
  int temp = array[p1];
  array[p1] = array[p2];
  array[p2] = temp;
}

2.2. Is this an "in-place" algorithm? Why/why not?

[DONE]

Yes, it modifies the existing list.

2.3. In what way is this algorithm "inserting" something? How is the insertion done in the code? Where in the array is something being inserted? What needs to happen to the contents of the array before insertion?

[DONE]

The insertion is done via swapping, using the "swap" function. Elements are inserted
depending on the arguments passed to swap. Before swapping, one of the array elements
needs to be stored in a temp variable so it isn't lost.

2.4. How could you re-write this algortihm in Java in a functional programming style? You do not need to write Java code ... just describe some ways you could change the code above.

[DONE]

Construct an ArrayList (or similar class) with a size equal to the given list/array,
and add each element of the given list to the ArrayList in a way that the ArrayList
always remains sorted.

2.5. Write insertion sort in Haskell by implementing the key idea of insertion in a functional way. Simply trying to duplicate every detail of the Java code is not recommended. Feel free to define extra functions to help you. Write your code in literate programming style, explaining what you are doing.

[DONE: Haskell Code Here, add >]

insertionSort - Takes a list and sorts it using insertion sort.
It goes through each item in the given list and inserts the item
into a new list, keeping that list sorted as it inserts.

>insertionSort :: Ord a => [a] -> [a]
>insertionSort arr = insert [] arr
>  where
>    insert :: Ord b => [b] -> [b] -> [b]
>    insert []     (x:xs) = insert [x] xs
>    insert x      []     = x
>    insert (x:xs) (y:ys)
>      | x >= y    = (insert (y:x:xs) ys)
>      | otherwise = (insert (insert xs (y:ys)) [x])

----------------------------------------------------------------

3.1. What is "selection sort"? Why is it called "selection sort"?

[TODO]

Look at this code for selection sort in Java and convince yourself that it is correct. Then answer the following questions.

public static void selectionSort(int[] array) {
  for(int i = 0; i < array.length - 1; i++) {
    for(int j = i+1; j < array.length; j++) {
      if(array[j] < array[i]) {
        swap(array, i, j); // defined as above
      }
    }
  }
}

3.2. Is this an "in-place" algorithm? Why/why not?

[TODO]

3.3. In what way is this algorithm "selecting" something? How is selection done in the code? What is happening to the thing that is selected?

[TODO]

3.4. How could you re-write this algortihm in Java in a functional programming style? You do not need to write Java code ... just describe some ways you could change the code above.

[TODO]

3.5. Write selection sort in Haskell by implementing the key idea of selection in a functional way. Simply trying to duplicate every detail of the Java code is not recommended. Feel free to define extra functions to help you. Write your code in literate programming style, explaining what you are doing.

[DONE: Haskell Code Here, add >]

>selectionSort :: Ord a => [a] -> [a]
>selectionSort [] = []
>selectionSort xs = let x = maximum xs in selectionSort (remove x xs) ++ [x] 
>  where remove _ [] = []
>        remove a (x:xs)
>          | x == a = xs
>          | otherwise = x : remove a xs

----------------------------------------------------------------

4.1. What is "merge sort"? Why is it called "merge sort"?

[DONE]

It "separates" the array/list into one-element lists, and merges them into
sorted lists. It keeps merging these sorted lists together until it ends up
as the original list, but sorted. When merging, it goes through each sorted
list left-to-right, adding whichever is lesser.

Look at this code for merge sort in Java and convince yourself that it is correct. Then answer the following questions.

public static void mergeSort(int[] array){
  mergeSort(array, 0, array.length - 1);
}
	
public static void mergeSort(int[] array, int start, int end){
  if(end <= start) return; // base case
	
  int mid = (start + end + 1) / 2; // integer division
  mergeSort(array, start, mid - 1); // sort left half of array
  mergeSort(array, mid, end); // sort right half of array
  merge(array, start, mid, end); // merge sorted halves
}
	
public static void merge(int[] array, int start, int mid, int end) {
  int[] temp = new int[end - start + 1];
  int i = start; // start of first sub-array to merge
  int j = mid; // start of second sub-array to merge
  int k = 0; // start of result array
  while(i < mid || j <= end){ // Go through sub-arrays in parallel until both are completely scanned
    // j > end: Second sub-array complete, so just add the rest of the first
    // i < mid: Make sure first sub-array is not finished before comparing array elements
    if(j > end || (i < mid && array[i] < array[j])){ // Choose from left sub-array
      temp[k++] = array[i++];
    } else { // Choose from right sub-array
      temp[k++] = array[j++];
    }
  }
  // Copy sorted results in temp back on to input array
  System.arraycopy(temp, 0, array, start, temp.length);
}

4.2. Is this an "in-place" algorithm? Why/why not?

[DONE]

Yes, the merge function creates an array but it is not used past that specific function,
and is instead copied into the existing array. Other than that no other arrays are
created/returned.

4.3. In what way is this algorithm "merging" something? How is the merge performed in the code? What exactly is being merged, and why does this lead to the desired result?

[DONE]

It is moving around elements in the array, given a certain index range: [start, mid) and [mid, end].
Certain segments of the existing array is being merged using the same method as described in 4.1,
recursively.

4.4. How could you re-write this algorithm in Java in a functional programming style? You do not need to write Java code ... just describe some ways you could change the code above.

[DONE]

Have the merge function take two arrays instead of certain index locations. mergeSort should have a definition
where it takes two arrays, with a base case checking if the array lengths are 1 or less.

4.5. Write merge sort in Haskell by implementing the key idea of merging in a functional way. Simply trying to duplicate every detail of the Java code is not recommended. Feel free to define extra functions to help you. Write your code in literate programming style, explaining what you are doing. If you get stuck, you can find some hints in the book.

[DONE: Haskell Code Here, add >]

mergeSort - Takes a list and sorts it using merge sort. It splits
the given list into two, recursively calls mergeSort on each list,
and merges the results together.

>mergeSort :: Ord a => [a] -> [a]
>mergeSort []  = []
>mergeSort [x] = [x]
>mergeSort x   = merge (mergeSort h1) (mergeSort h2)
>  where
>    (h1,h2) = splitAt ((length x) `quot` 2) x
>    merge :: Ord b => [b] -> [b] -> [b]
>    merge x      []     = x
>    merge []     x      = x
>    merge (x:xs) (y:ys)
>      | x <= y    = x:(merge xs (y:ys))
>      | otherwise = y:(merge (x:xs) ys)

----------------------------------------------------------------

5.1. By this point, you have probably already tested some of your code informally. What have you done? Are you confident that the tests you have run so far are complete enough to cover all cases?

[DONE]

Yes, all have been tested.

5.2. It is generally a good idea to have test cases that can quickly verify the correct functioning of your code. Such testing is especially useful if your code changes, and you want to make sure you haven't broken anything. What sort of automated checks do you need in order to verify the correct functioning of a sorting algorithm? Given a specific input, what do you need to verify about the input (output?) in order to know that it is correct?

[DONE]

Test cases would need to verify that certain arrays being sorted are actually sorted, and that the
algorithm doesn't error on certain unexpected lists, such as empty lists or a one-element list.

Consider the following function

>check :: Ord a => ([a] -> [a]) -> [a] -> Bool
>check f xs = correctOutputForInput xs (f xs)

This is a "higher-order" function. It takes a function as input, specifically a function that maps a list of ordered items to a list of ordered items. This function is represented by f in the function body of check. The variable xs represents a list of ordered items, and the final output is a Boolean value. This function is supposed to take a sorting function and a list of ordered items as input, and then indicate whether or not the function correctly sorts the list. However, the check function depends on another function called correctOutputForInput, that you must write. 

5.3. Write the correctOutputForInput function below. It currently returns True all the time, but you need to change this. The function should return True if the second input is the expected sorted output corresponding to the first input. In other words, (correctOutputForInput xs ys) should return True whenever ys is the result you expect from applying any of your sorting algorithms to xs, and False otherwise. You may need a few helper functions. As usual, write your code in the literate style.

>correctOutputForInput :: Ord a => [a] -> [a] -> Bool

[DONE: Haskell Code Here, change function definition]

>correctOutputForInput xs ys = and [(isSorted ys), (isRearranged xs ys)]
>  where
>    isSorted :: Ord a => [a] -> Bool
>    isSorted []        = True
>    isSorted [g]       = True
>    isSorted (g:h:hs)
>      | g > h          = False
>      | otherwise      = isSorted (h:hs)
>    isRearranged :: Ord a => [a] -> [a] -> Bool
>    isRearranged []     [y] = False
>    isRearranged [x]    []  = False
>    isRearranged []     []  = True
>    isRearranged (x:xs) ys = isRearranged xs (delete x ys)
>      where
>        delete j []        = []
>        delete j (k:ks)
>          | j == k         = ks
>          | otherwise      = k:(delete j ks)

5.4. Below are some test cases. If you define correctOutputForInput correctly, then you can use these lists with the check function to test your code. For example, (check selectionSort case1) will return True if both selectionSort and correctOutputForInput are correctly defined. Provide at least 7 more test cases to test your code. Your group may share test cases with anyone in the class, but at least half of the test cases below must be from your group. If you get test cases from others, you must identify who you got each test case from.

>case1 = [1,2,3,4]
>case2 = [9,8,6,4,3,2]
>case3 = [-34,6,1,-69,435,0,34,657,-179]

[DONE: Haskell Code Here, add test cases]

>case4 = []
>case5 = [50]
>case6 = [100,99..(-100)]
>case7 = ([1..20] ++ [15..40])
>case8 = ([(-50),(-48)..(-26)] ++ [(-30),(-32)..(-50)])
>case9 = [5,5,5,5,5]
>case10 = [1000,999..1]

>cases = [case1, case2, case3, case4, case5, case6, case7, case8, case9, case10]
>checkAllShowList f = map (check f) cases
>checkAll f         = and (checkAllShowList f)

----------------------------------------------------------------

6.1 Final assessment: Below this point you should write a short report (about 2-4 paragraphs) explaining what you learned from this assignment. At a minimum, your report should touch on the following topics: 
1. What can you not do in Haskell, and how did you get around it?
2. How were your algorithms similar/different from the Java versions?
3. Which algorithms do you think were simpler to write/understand and why?
4. What errors/bugs did you have to deal with, and how did you fix them? 
5. Did your test cases help you find/fix bugs?
6. If there are still bugs, then describe them.

[DONE]

We could not easily modify lists by getting/setting content via indicies. Our algorithms
were very different from the Java versions, as none of them were "in-place" and relied
heavily on recursion. They were all easier to write, as no confusing indicies were involved,
and no swapping. We didn't have any real bugs in the sorting algorithms, and the test cases
(along with manually looking at the results) seem to agree.

Lastly, please rate this assignment on the following 1 to 10 scales:

Difficulty (1 is easy, 10 hard): 6
Interesting (1 boring, 10 interesting): 4
Worth (1 worthless, 10 worth doing): 5

If you have any more comments about this assignment, put them below:

[DONE]

Finally, type out the honor code below, followed by each member's name. Also, describe any help you received from any source, including me:

[TODO]

Sources: Textbook