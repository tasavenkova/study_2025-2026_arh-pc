%include 'in_out.asm'
SECTION .data
msg: DB 'Введите x: ',0
result: DB 'f(g(x))=2*(3x-1)+7=',0
SECTION .bss
x: RESB 80
res: RESB 80
SECTION .text
global _start
_start:
; Основная программа
mov eax, msg
call sprint
mov ecx, x
mov edx, 80
call sread
mov eax, x
call atoi
call _calcul ; Вызов подпрограммы _calcul
mov eax, result
call sprint
mov eax, [res]
call iprintLF
call quit

; Подпрограмма вычисления f(g(x)) = 2*(3x-1)+7
_calcul:
push eax ; Сохраняем x в стеке
call _subcalcul ; Вызов подпрограммы _subcalcul (вычисляем g(x) = 3x-1)
; В eax теперь результат g(x)
mov ebx, 2 ; f(x) = 2x+7
mul ebx ; 2 * g(x)
add eax, 7 ; 2*g(x) + 7
mov [res], eax ; Сохраняем результат
pop eax ; Восстанавливаем регистр (не обязательно, но для чистоты)
ret ; выход из подпрограммы

; Подпрограмма вычисления g(x) = 3x-1
_subcalcul:
; В eax передано значение x
mov ebx, 3
mul ebx ; 3*x
sub eax, 1 ; 3x-1
ret ; возвращаем результат в eax
