; ECE 362 Lab 3 - Fall 2014 - Step 1

; Name: < Kyunghoon Jung >

; Lab: < Section 4, W 8:30 - 11:20 >

; Class Number: < 5413-J >

; Use Code Warrior (CW) in Full Chip Simulation mode

;***********************************************************************
;
; Write a REENTRANT subroutine "findc" that counts the number of instances
; of a specified (ASCII) character in the string that is passed to it.
; Recall that a reentrant subroutine does not use any global variables
; (i.e., any local variables utilized should be allocated on the stack.
;
; At entry, the (ASCII) character to match along with the string to search
; is passed via the stack, as shown; assume the string terminates with the
; ASCII NULL character (the string can be any length up to 255 characters).
;
; At exit, the number of instances of the specified character is returned
; via the stack (as an unsigned 8-bit binary number) in place of the character
; that was matched (the string should be deallocated from the stack).
;
; At entry:
;
;      +--------------------+
; SP ->| return address - H |
;      +--------------------+
;      | return address - L |
;      +--------------------+
;      | character to match |
;      +--------------------+
;      | string - firstchar |
;      +--------------------+
;      |       char         |
;      +--------------------+
;      |       char         |
;      +--------------------+
;      | string - lastchar  |
;      +--------------------+
;      |     ASCII NULL     |
;      +--------------------+
;                      
;
; Just prior to exit:
;
;      +--------------------+
; SP ->| return address - H |
;      +--------------------+
;      | return address - L |
;      +--------------------+
;      | number of matches  |
;      +--------------------+
;
;***********************************************************************
;
; To test and auto-grade your solution:
;	- Use CodeWarrior to assemble your code and launch the debugger
;	- Load the Auto-Grader (L3AG-1.s19) into the debugger
;		> Choose File -> Load Application
;		> Change the file type to "Motorola S-Record (*.s*)"
;		> Navigate to the 'AutoGrade' folder within your project
;		> Open 'L3AG-1.s19'
; - Open and configure the SCI terminal as a debugger component
;	- Start execution at location $800
;
; The score displayed is the number of test cases your code has passed.
; If nothing is displayed (i.e., your code "crashes"), no points will be
; awarded - note that there is no way to "protect" the application that
; tests your code from stack errors inflicted by mistakes in your code.
;
; Also note: If the message "STACK CREEP!" appears, it means that the
; stack has not been handled correctly (e.g., more pushes than pops or
; data passed to it not de-allocated correctly). 
;
;***********************************************************************

	org	$A00	; DO NOT REMOVE OR MODIFY THIS LINE

; Place your code for "findc" below

findc
       puld
       std address
       pula
       staa charrem
       ldab #0
cnt_c  
       pula
       cmpa #$00
       beq  cexit
       cmpa charrem
       beq increment
       bra cnt_c
cexit  
       pshb
       ldd  address
       pshd
       rts
       
increment
       incb
       bra cnt_c       
       
address
       rmb 2
charrem
       rmb 1