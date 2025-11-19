%include 'in_out.asm'

SECTION .data
    msg_x db "Введите x: ",0
    msg_a db "Введите a: ",0
    msg_result db "f(x) = ",0
    newline db 0xA,0
    
SECTION .bss
    x resd 1
    a resd 1
    result resd 1

SECTION .text
global _start

_start:
    ; Ввод переменной x
    mov eax, msg_x
    call sprint
    mov ecx, x
    mov edx, 10
    call sread
    mov eax, x
    call atoi
    mov [x], eax
    
    ; Ввод переменной a
    mov eax, msg_a
    call sprint
    mov ecx, a
    mov edx, 10
    call sread
    mov eax, a
    call atoi
    mov [a], eax
    
    ; Вычисление функции f(x) по условию с картинки
    mov eax, [a]      ; загружаем a в eax
    cmp eax, 1        ; сравниваем a с 1
    je case_a_equal   ; если a = 1, переходим ко второму случаю
    
    ; Случай 1: a ≠ 1, f(x) = a²
case_a_not_equal:
    mov eax, [a]      ; загружаем a
    imul eax, eax     ; eax = a * a (a²)
    jmp print_result
    
    ; Случай 2: a = 1, f(x) = 10 + x
case_a_equal:
    mov eax, 10       ; eax = 10
    add eax, [x]      ; eax = 10 + x
    
print_result:
    ; Сохраняем результат
    mov [result], eax
    
    ; Вывод результата
    mov eax, msg_result
    call sprint
    mov eax, [result]
    call iprintLF
    
    ; Завершение программы
    call quit
