@SUM_RESULT
M=0

@INPUT_OPERAND
D=M
@NON_POSITIVE_CHECK
D;JGT
@TERMINATE_EXECUTION
0;JMP
(NON_POSITIVE_CHECK)

@LOOP_COUNTER
M=0
@MEMORY_BASE
D=M
@CURRENT_ADDRESS
M=D

(PROCESS_ITERATION)
@LOOP_INDEX
M=0
@LOOP_COUNTER_VAR
D=M
@INPUT_OPERAND_COMPARE
D=M-D
@ITERATION_COMPLETE
D;JEQ
@ITERATION_CONTINUE
0;JMP

(ITERATION_CONTINUE)
@CURRENT_ADDRESS_PTR
A=M
D=M
@ACCUMULATOR
M=D
@SUM_RESULT_VAR
D=M
@ACCUMULATOR
D=D+M
@SUM_RESULT_VAR
M=D

@ADVANCE_POINTER
M=1
@CURRENT_ADDRESS_PTR
M=M+1
@INCREMENT_COUNTER
M=1
@LOOP_COUNTER_VAR
M=M+1

@ITERATION_REPEAT
0;JMP

(ITERATION_REPEAT)
@PROCESS_ITERATION
0;JMP

(ITERATION_COMPLETE)
(TERMINATE_EXECUTION)
@TERMINATE_EXECUTION
0;JMP