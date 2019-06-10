# Arquitectura
<h1>Emulador 8086</h1>
  <h2> 1.	Introducción</h2>
<P ALIGN="justify">El emu8086 es un emulador del microprocesador 8086 (Intel o AMD compatible) con assembler integrado. A diferencia del entorno de programación en assembler utilizado anteriormente en la cátedra (MASM), este entorno corre sobre Windows y cuenta con una interfaz gráfica muy amigable e intuitiva que facilita el aprendizaje el leguaje de programación en assembler. </p>
  <center><img src="p1.png" width="300" height="250"></center>
 <h3> 1.1.	Tamaño de los datos </h3>
En el 8086/88 se definen los siguientes tamaños de datos:    

                4 bits - nibble   
                8 bits - byte
                16 bits - word
                32 bits - dword 

<h3> 1.2.	Almacenamiento de datos </h3>
<P ALIGN="justify">El 8086/88 usa el formato de almacenamiento denominado “little endian”, esto quiere decir que el byte menos significativa (LSB) del dato es guardada en la parte baja de la memoria. Por ejemplo el dato 0x1122 será almacenado en memoria: Es importante tener esto en cuanta a la hora de acceder a los datos para operar con ellos. 
<h3> 1.3.	 Segmentación </h3>
<P ALIGN="justify">El 8086/88 tiene un ancho de bus de datos de 16 bits y un ancho de bus de direcciones de 20 bits. Con 20 bits de direcciones se puede acceder a 220 = 1 Mega posiciones de memoria. Como cada dirección de memoria contiene un byte, el total de memoria accedido por el procesador es de 1 Mbyte. El bus de datos de 16 bits lo que implica que en cada acceso a memoria se leen dos 22 11 000….0 FFF….F Ensamblador 8086/88 2 posiciones. Esta es la razón por que la que es importante saber el modo de almacenamiento de los datos en memoria, visto en el apartado anterior. El problema que se les planteó a los diseñadores fue que siendo los registros internos del procesador de 16 bits, y el bus de direcciones de 20; faltaban 4 bits para poder aprovechar al máximo las capacidades de direccionamiento del procesador. Para resolver esto, cada dirección de memoria será especificada como un segmento y un desplazamiento dentro de ese segmento. Esta solución divide la memoria en segmemtos de 64 K, lo cual limitó bastante los diseños de los procesadores posteriores de la familia (80286,80386 etc.); aunque posteriormente se idearon métodos para resolver este problema, como la memoria extendida (no compatible, por supuesto, con el 8086/88). Así pues el 8086/88 dispone de una serie de registros para almacenar los valores de segmentos, como veremos en los siguientes apartados. Para obtener la dirección de memoria (dirección efectiva): se toma el valor de registro de segmento, se desplaza 4 bits, y se le suma el valor del desplazamiento. Segmento 0000 0000 0000 1010 desplazado 4 bits Desplazamiento + 0101 1111 0000 1010 Dirección efectiva 0000 0101 1111 0101 1010 Esta operación la realiza el procesador de forma interna automáticamente.

  <h2> 2.	Utilización del entorno</h2>
    <h3> 2.1	Iniciar</h3>
     <p> Para iniciar el entorno se deje ejecutar el archivo emu8086.exe que se encuentra en el directorio de instalación (ej. c:\emu8086). </p>
       <center><img src="p2.png" width="300" height="250"></center>
     <h3> 2.2	Diferentes templantes</h3>
       <p>Luego de iniciar el entorno el emu8086 ofrece diferentes opciones: </p>
                                                                                                                                                      <P><B> • New: </B> permite escribir un nuevo código en lenguaje ensamblador (“Código Fuente” con extensión .ASM) </p>
             <P><B>• Code examples: </B> a una serie de programas ejemplos muy útiles al momento de aprender a utilizar el                         entorno y la programación en assembler.</p>
             <P><B>• Quick start tutor:</B>  llama al browser y permite explorar gran variedad de documentos de ayuda. </p>
             <P><B>• Recent file:</B>  muestra los últimos archivos con los cuales se estuvo trabajando. En el caso de hacer click en New, el entorno ofrece trabajar con diferentes plantillas o templates:
                         <center><img src="p3.png" width="300" height="250"></center>
  <P><B> •COM template (directiva #make_com#): </B> es el formato más simple y antiguo de un archivo ejecutable, típicamente estos archivos se cargan con un offset de 100h (256 bytes). Por esta razón se debe agregar la directiva ORG 100h al comienzo del código para indicar la utilización de este tipo de archivos. Formato soportado por DOS y Windows Command Prompt.  
<P><B>•	EXE template (directiva #make_exe#): </B>este es el formato más avanzado de un archivo ejecutable. No tiene limitaciones en cuanto al tamaño del archivo y número de segmentos. Este template permite crear un programa exe simple con los segmentos de código, datos y pila predefinidos. Este tipo de archivo está soportado por Windows y Windows Command Prompt. El ensamblador elige automáticamente este tipo de archivo cuando encuentra definido un segmento de pila. 
<P><B>•	BIN template (directiva #make_bin#):</B> es un archivo ejecutable simple. Permite definir el valor de todos los registros, segmentos y el lugar de memoria donde se cargará a este programa. Cuando por ejemplo el ensamblador carga el archivo "MY.BIN" en el emulador buscará el archivo "MY.BINF" y cargará al archivo "MY.BIN" en la ubicación especificada en "MY.BINF", al igual que el valor inicial configurado para todos los registros. En el caso de que el emulador no encuentre al archivo "MY.BINF", se utilizará el valor actual de los registros al momento de la ejecución del .BIN y este código se ubicará en los valores que tengan en ese momento CS:IP. 
<P><B>•	BOOT template (directiva #make_boot#):</B> funciona igual de que un .BIN, pero utiliza valores predefinidos para ubicar el código y que coinciden con el primer track de un floppy disk (boot sector). La única diferencia con la directiva #make_bin# es que carga el código en la dirección predefinida 0000:7c00h. Este template permite emular el bootedo de una IBM PC desde el floppy disk.

<h3> 2.3	Ventana emulador.</h3>
<P ALIGN="justify">A los fines de avanzar con los primeros pasos con el emu8086, en esto caso seleccionaremos la opción “empty                          workspace”. Luego de esto tendremos acceso a la ventana principal del emulador que cuenta con una barra de menú de Windows (file, edit, bookmarks, assembler, etc.) y varios botones de uso frecuente como New, Open, Save, Compile o Emulate. Esta ventana es en definitiva un editor de texto que permite crear y editar el código fuente de assembler.
                         <center><img src="p4.png" width="300" height="250"></center>
<h3> 2.4	Código de la suma de 2 números</h3>
 <P ALIGN="justify"> <img src="p5.png" width="300" height="250">
<h3> 2.5	Emulate</h3>
 <P ALIGN="justify"> Al hacer clic en el en “Emulate”, se tendrá acceso a gran variedad de funciones e información y seleccionamos run:
   <center><img src="p6.png" width="300" height="250"></center>
<h3> 2.6 Compilamos nuestro ejercicio y mostramos a la pantalla:</h3>
 <P ALIGN="justify">
  <center><img src="p7.png" width="300" height="250"></center>
                        
