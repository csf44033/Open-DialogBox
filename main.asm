INCLUDELIB	kernel32.lib
INCLUDELIB	user32.lib
.DATA
	INCLUDE	./data/include.asm
.DATA?
	INCLUDE	./data/bss.asm
.CODE
;entry point
	start PROC
;homespace
	;PUSH	rsp
	SUB		rsp, 030h
;GetModuleHandleA
	XOR		rcx, rcx
	CALL	GetModuleHandle
	MOV		phInstance, rax
;DialogBoxParam
	MOV		rcx, phInstance
	LEA		rdx, lpTemplateName
	XOR		r8, r8
	LEA		r9, DialogProc
	XOR		rax, rax
	MOV		[rsp + 020h], rax
	CALL	DialogBox
	CALL	GetLastError
;clearstack
	;POP		rsp
	ADD		rsp, 030h
	start ENDP
	END
DialogProc:
	XOR		rax, rax
	END