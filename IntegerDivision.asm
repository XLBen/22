//R0 (dividend)
//R1 (divisor)
//R2 (quotient)
//R3 (remainder)
//R4 (error flag: 0=normal, 1=division by zero error)
// Registers used: R5 (dividend sign flag), R6 (divisor sign flag), ABS_R0 (dividend absolute value), ABS_R1 (divisor absolute value)

@R1 // Load divisor
D=M // Store divisor in D register
@DIVIDE_BY_ZERO // Prepare to handle division by zero error
D;JEQ // If divisor is 0, jump to error handling

@R0 // Load dividend
D=M
@R5 // Initialize dividend sign flag
M=0 // Default is positive
@SKIP_R0_NEG // Prepare to skip negative number processing
D;JGE // Skip if dividend ≥ 0
@R5 // Handle negative dividend
M=1 // Set to negative
(SKIP_R0_NEG) // Negative number processing completed
@R0 // Reload dividend
D=M
@ABS_R0 // Prepare to store absolute value
M=D // Store original value first
@SKIP_R0_ABS // Prepare to skip absolute value conversion
D;JGE // Skip if already positive
@ABS_R0 // Convert to absolute value
M=-D // Negate negative number
(SKIP_R0_ABS) // Absolute value conversion completed

@R1 // Load divisor
D=M
@R6 // Initialize divisor sign flag
M=0 // Set to positive by default
@SKIP_R1_NEG // Prepare to skip negative number processing
D;JGE // Skip if divisor ≥ 0
@R6 // Process negative divisor
M=1 // Set to negative
(SKIP_R1_NEG) // Negative number processing completed
@R1 // Reload divisor
D=M
@ABS_R1 // Prepare to store absolute value
M=D // Store original value first
@SKIP_R1_ABS // Prepare to skip absolute value conversion
D;JGE // Skip if already positive
@ABS_R1 // Convert to absolute value
M=-D // Negate negative number
(SKIP_R1_ABS) // Absolute value conversion completed

// Check for overflow
@ABS_R0 // Load absolute value of dividend
D=M
@32768 // Load minimum negative number (-32768)
D=D-A // Check if equal to -32768
@CHECK_OVERFLOW // Prepare for overflow check
D;JEQ // If -32768, check for overflow
@START_DIVISION // Otherwise perform division normally
0;JMP // Jump to start of division

(CHECK_OVERFLOW) // Handle potential overflow
@ABS_R1 // Load absolute value of divisor
D=M
@1 // Check if the divisor is 1
D=D-A
@OVERFLOW_ERROR // Prepare for overflow error handling
D;JEQ // If the divisor is 1, overflow occurs
@START_DIVISION // Otherwise, perform division normally
0;JMP // Jump to the start of division

// Main division loop
(START_DIVISION) // Start division algorithm
@ABS_R0 // Load the absolute value of the dividend
D=M
@R3 // Initialize the remainder
M=D // Initial remainder = dividend
@R2 // Initialize the quotient
M=0 // Initial quotient = 0

(LOOP) // Division loop
@ABS_R1 // Load the absolute value of the divisor
D=M
@R3 // Load the current remainder
D=M-D // Remainder - divisor
@END_LOOP // Prepare to exit the loop
D;JLT // If remainder < divisor, division is complete
@ABS_R1 // Otherwise, subtract the divisor from the remainder
D=M
@R3
M=M-D // Remainder = Remainder - Divisor
@R2 // Add 1 to the quotient
M=M+1 // Quotient = Quotient + 1
@LOOP // Continue division loop
0;JMP