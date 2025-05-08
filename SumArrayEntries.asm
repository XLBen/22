@R2 // Read the address of R2
M=0 // R2 = 0 (initialize accumulator)

@R1 // Read the address of R1
D=M // D = value of R1 (array length)
@END // Prepare to jump to END
D;JLE // If D <= 0, end directly (invalid array length)

// Initialize loop variables
@R3 // Read the address of R3
M=0 // Clear loop counter
@R0 // Read the address of R0
D=M // Array start address
@R4 // Read the address of R4
M=D // Save current pointer position

// Main loop
(LOOP)
@R3 // Read the address of R3
D=M // D = current loop count
@R1 // Read the address of R1
D=D-M // D = count - array length
@END_LOOP // Prepare to jump to END_LOOP
D;JEQ // If count == Array length, end loop

// Accumulate
@R4 // Read current pointer
A=M // A = current pointer value
D=M // D = current array element value
@R2 // Read address of R2
M=D+M // R2 += current element value

// Update pointer and counter
@R4 // Read address of R4
M=M+1 // Move to next element
@R3 // Read address of R3
M=M+1 // Loop count++
@LOOP // Prepare to jump back to LOOP
0;JMP // Continue loop unconditionally

// End of loop
(END_LOOP)
// Program terminates
(END)
@END // Read address of END
0;JMP