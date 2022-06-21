Copyright 2022 Maria Sfiraiala (maria.sfiraiala@stud.acs.upb.ro)

# Summer Advent - Day1

-------------------------------------------------------------------------------

## Challange1

### inc2
- We compute mathematical expression 3 * x + 10 and we return it.

### is_odd
- We check whether a given value is odd, by using the test mnemonic.

### map
- We dynamically allocate an array and we populate it with results returned by
a function given as a parameter.

### filter
- We dynamically allocate an array and we populate it with a certain value from
another array given as a parameter, when its elements, after being checked
through a function are valid.
- In the end, we reallocate the space, in order to perfectly emulate its exact
lenght.

### print_array
- Self explanatory.

### main
- We check the aforementioned functions.

-------------------------------------------------------------------------------

## Challange2

### alloc_array
- Self explanatory.

### read_array
- Ibidem.

### sum_array
- Constructs the sum of the values stored in a given array.

### main
- Checks the already implemented functions.

-------------------------------------------------------------------------------

## Challange3

### a)
- We read the string using fgets, we parse its words using strtok and for every
first letter we check whether its upper or lower, if lower, we substract 32
from it in order to make it a capital letter.

### b)
- We use a frequency array in order to store the number of appearances for
every letter.
- The implemenation is based on the observation that both upper and lower
letters range from 65 to 172.

-------------------------------------------------------------------------------

## Challange4

- SummerAdvent{forget_everything_that_you_think_you_know}
- We captured the flag by using both Ghidra and objdump.
- Ghidra was used in order to get the C source by decompiling the elf file.
Having acces to the main, we, had to also use a buffer overflow attack to
overwrite the return address and to call the get_in function which was going
to further call the get_flag subroutine.
- Using objdump we were able to determine the payload we had to use in order to
overwrite the return address: 1064 + the other two values needed for the 
function address and its parameter.
- We used this command to generate the final payload: 

**python -c 'print "A" * 1064 + "\x84\x93\x04\x08" + "\xb8\xb1\xb0\xa8"' | ./day1**

-------------------------------------------------------------------------------

