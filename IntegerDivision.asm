(INTEGER_DIVISION)
// Check 0
@R1 // Load the divisor to the D register
D=M
@INVALID_DIVISION // If the divisor is 0, jump to error handling
D;JEQ

// Initialize
@0
D=A
@R4
M=D

// Check R0
@R0
D=M
@X_POSITIVE // If the dividend ≥ 0, jump to X_POSITIVE
D;JGE

//dividend is negative
@R7 // R7 stores the dividend sign flag
M=-1 // -1 means the dividend is negative
@CHECK_Y_SIGN // Jump to check the divisor sign
0;JMP

(X_POSITIVE) // If the dividend is non-negative
@R7 // R7 stores the dividend sign flag
M=1 // 1 means the dividend is positive

(CHECK_Y_SIGN) // Check the sign of R1
@R1
D=M
@Y_POSITIVE // If the divisor ≥ 0, jump to Y_POSITIVE
D;JGE

//negative divisor
@R8 // R8 stores the divisor sign flag
M=-1 // -1 means the divisor is negative
@ABS_VALUES // Jump to absolute value calculation
0;JMP

(Y_POSITIVE) // In the case of a non-negative divisor
@R8 // R8 stores the divisor sign flag
M=1 // 1 means the divisor is positive

(ABS_VALUES) // Calculate the absolute value part
// Process the absolute value of the dividend
@R0
D=M
@x_ABS // x_ABS stores the absolute value of the dividend
M=D // Store the original value first

@R7 // Check the sign of the dividend
D=M
@SKIP_NEGATE_X // If the dividend is positive (R7=1), skip negation
D;JGT

//dividend is negative
@x_ABS
D=M // Load the dividend value
M=-D // Negate to get the absolute value

(SKIP_NEGATE_X) // Skip negation of the dividend

// Process the absolute value
@R1
D=M
@y_ABS // y_ABS stores the absolute value of the divisor
M=D // Store the original value first

@R8 // Check the sign of the divisor
D=M
@SKIP_NEGATE_Y // If the divisor is positive (R8=1), skip negation
D;JGT

// If the divisor is negative
@y_ABS
D=M // Load the divisor value
M=-D //absolute value


// Skip negation of the divisor
(SKIP_NEGATE_Y) 

// Initialize quotient and remainder
@0
D=A
@quotient // quotient initialized to 0
M=D

@x_ABS
D=M
@remainder // remainder initialized to the absolute value of the dividend
M=D
// Main division loop
(DIVISION_LOOP) 
// Check if remainder is less than divisor
@remainder
D=M
@y_ABS
D=D-M // Calculate remainder-divisor
@END_DIVISION // If remainder < divisor, end loop
D;JLT

// Perform a subtraction
@y_ABS
D=M
@remainder
M=M-D // Remainder = remainder - divisor

// Add 1 to quotient
@quotient
M=M+1

// Continue loop
@DIVISION_LOOP
0;JMP

(END_DIVISION) // End division processing
// Determine the sign of the quotient
@R7 // Compare the signs of the dividend and divisor
D=M
@R8
D=D-M // Calculate the sign difference
@SAME_SIGN // If the signs are the same (D=0), skip the quotient
D;JEQ

// Different signs, negate the quotient
@quotient
D=M
M=-D

(SAME_SIGN) // Process the remainder sign
// Check the dividend sign
@R7
D=M
@ADJUST_REMAINDER // If the dividend is positive (R7=1), skip the remainder negation
D;JGT

// If the dividend is negative, negate the remainder
@remainder
D=M
M=-D

(ADJUST_REMAINDER) // Store the final result
// Store the quotient in R2
@quotient
D=M
@R2
M=D

// Store the remainder in R3
@remainder
D=M
@R3
M=D

// Program ends
@END
0;JMP

(INVALID_DIVISION) // Handle division by zero error
// Set error flag
@1
D=A
@R4
M=D

// Quotient and remainder set to 0
@0
D=A
@R2
M=D
@R3
M=D

// Program ends
@END
0;JMP

(END) // Program end label
@END
0;JMP