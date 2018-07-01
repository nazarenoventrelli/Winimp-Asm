.data
coorX: .byte 12 ; coordenada X de un punto
coorY: .byte 24 ; coordenada Y de un punto
color: .byte 0, 255, 0; color: máximo rojo + máximo azul => magenta
rosa: .byte 251, 40, 219;
verde: .byte 81, 232, 60;
rojo: .byte 223, 0,0;
amarillo: .byte 218, 223, 0;

CONTROL: .word32 0x10000
DATA: .word32 0x10008
.text

lwu $s6, CONTROL(r0) ; $s6 = dirección de CONTROL
lwu $s7, DATA(r0) ; $s7 = dirección de DATA

daddi $t0, $0, 7 ; $t0 = 7 -> función 7: limpiar pantalla gráfica
sd $t0, 0($s6) ; CONTROL recibe 7 y limpia la pantalla gráfica


lwu $s2, color(r0) ; $s2 = valor de color a pintar
sw $s2, 0($s7) ; DATA recibe el valor del color a pintar

lbu $s0, coorX(r0) ; $s0 = valor de coordenada X
sb $s0, 5($s7) ; DATA+5 recibe el valor de coordenada X

lbu $s1, coorY(r0) ; $s1 = valor de coordenada Y
sb $s1, 4($s7) ; DATA+4 recibe el valor de coordenada Y

jal L
jal O
jal V
jal E
halt



PINTA: 

daddi $t0, $0, 5 ; $t0 = 5 -> función 5: salida gráfica
sd $t0, 0($s6) ; CONTROL recibe 5 y produce el dibujo del punto

jr $ra

ABAJO: daddui $s1,$s1,-1
sb $s1, 4($s7) ; DATA+4 recibe el valor de coordenada Y
jr $ra

ARRIBA: daddui $s1,$s1,1
sb $s1, 4($s7) ; DATA+4 recibe el valor de coordenada Y
jr $ra


IZQ: daddui $s0,$s0,-1
sb $s0, 5($s7) ; DATA+5 recibe el valor de coordenada X
jr $ra


DER: daddUi $s0,$s0,1
sb $s0, 5($s7) ; DATA+5 recibe el valor de coordenada X
jr $ra


ROSA: lwu $s2, rosa(r0) ; $s2 = valor de color a pintar
sw $s2, 0($s7) ; DATA recibe el valor del color a pintar
jr $ra

VERDE: lwu $s2, verde(r0) ; $s2 = valor de color a pintar
sw $s2, 0($s7) ; DATA recibe el valor del color a pintar
jr $ra

ROJO: lwu $s2, rojo(r0) ; $s2 = valor de color a pintar
sw $s2, 0($s7) ; DATA recibe el valor del color a pintar
jr $ra

AMARILLO: lwu $s2, amarillo(r0) ; $s2 = valor de color a pintar
sw $s2, 0($s7) ; DATA recibe el valor del color a pintar
jr $ra


L: dadd $t1,$ra,r0
jal ROSA
jal PINTA
jal ABAJO
jal PINTA
jal ABAJO
jal PINTA
jal DER
jal PINTA

jr $t1

O: dadd $t1,$ra,r0

jAL VERDE
jal DER
jal DER
jal PINTA
jal ARRIBA
jal PINTA
jal ARRIBA
jal PINTA
jal DER
jal PINTA
jal DER
jal PINTA
jal ABAJO
jal PINTA
jal ABAJO
jal PINTA
jal IZQ
jal PINTA
jal DER
jal DER

jr $t1

V: dadd $t1,$ra,r0

JAL ROJO
jal DER
jal ARRIBA
jal PINTA
jal ARRIBA
jal PINTA
jal DER
jal ABAJO
jal ABAJO
jal PINTA
jal DER
jal ARRIBA
jal PINTA
jal ARRIBA
jal PINTA

jr $t1

E: dadd $t1,$ra,r0

jal AMARILLO
jal DER
jal DER
jal ARRIBA
jal PINTA
jal DER
jal PINTA
jal DER
jal PINTA
jal ABAJO
jal IZQ
jal IZQ
jal PINTA
jal ABAJO
jal PINTA
jal DER
jal PINTA
jal DER
jal PINTA
jal ABAJO
jal IZQ
jal IZQ
jal PINTA
jal ABAJO
jal PINTA
jal DER
jal PINTA
jal DER
jal PINTA

jr $t1



















