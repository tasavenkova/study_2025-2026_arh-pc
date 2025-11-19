%include 'in_out.asm'

SECTION .data
    a DD 83
    b DD 73  
    c DD 30
    msg_min DB 'Наименьшее число: ',0

SECTION .text
GLOBAL _start
_start:
    ; Находим минимум среди a, b, c
    mov eax, [a]         ; Предполагаем, что a - минимальное
    
    ; Сравниваем с b
    mov ebx, [b]
    cmp eax, ebx
    jl check_c           ; Если a < b, проверяем c
    mov eax, ebx         ; Иначе минимум = b
    
check_c:
    ; Сравниваем текущий минимум с c
    mov ebx, [c]
    cmp eax, ebx
    jl print_min         ; Если текущий минимум < c, выводим
    mov eax, ebx         ; Иначе минимум = c
    
print_min:
    ; Вывод результата
    push eax             ; Сохраняем результат
    
    mov eax, msg_min     ; Вывод сообщения
    call sprint
    
    pop eax              ; Восстанавливаем результат
    call iprintLF        ; Вывод числа
    
    call quit            ; Завершение
