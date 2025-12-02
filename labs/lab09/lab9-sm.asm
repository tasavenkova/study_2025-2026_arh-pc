%include 'in_out.asm'

SECTION .data
msg_func db "Функция: f(x) = 17 + 5x", 0
msg_result db "Результат: ", 0

SECTION .text
global _start

_start:
mov eax, msg_func
call sprintLF

; Получаем количество аргументов
pop ecx  ; argc
pop edx  ; argv[0] - имя программы
sub ecx, 1  ; исключаем имя программы
mov esi, 0  ; общая сумма

; Проверяем, есть ли аргументы
cmp ecx, 0
jz _end

next:
; Берем следующий аргумент
pop eax
call atoi  ; преобразуем строку в число

; ВЫЗОВ ПОДПРОГРАММЫ для вычисления f(x) = 5x + 17
call _calcul

; Добавляем результат к общей сумме
add esi, eax

; Переходим к следующему аргументу
loop next

_end:
mov eax, msg_result
call sprint
mov eax, esi
call iprintLF
call quit

; ПОДПРОГРАММА вычисления f(x) = 5x + 17
; Вход: eax = x
; Выход: eax = 5x + 17
_calcul:
push ebx        ; Сохраняем ebx
mov ebx, 5      ; Коэффициент 5
mul ebx         ; eax = 5 * x
add eax, 17     ; eax = 5x + 17
pop ebx         ; Восстанавливаем ebx
ret             ; Возврат из подпрограммы
