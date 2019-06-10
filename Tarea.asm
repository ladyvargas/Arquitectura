
   ;Ejemplo de un lenjuage ensamblador - Emu8086
   include "emu8086.inc"   
   
   .data
   Suma db 2 dup(?)
   
   Sumas proc 
    printn "Ingresar el primer numero;"
    call scan_num
    mov suma[0],cl
    printn ""
    printn "Ingresar el segundo numero;"
    call scan_num
    mov suma[1],cl
    printn ""
    
    xor ax,ax
    add al,suma[0]
    add al,suma[1]
    printn ""  
    printn "La suma es:" 
    call print_num  
    
    sumas endp
   exit:
   
   printn ""
   printn "Presione enter para salir..." 
   mov ah, 0
   int 16h
   ret
   
   define_print_string
   define_print_num
   define_print_num_uns
   define_scan_num
   end
    
    
    
