#!/bin/bash
#este comando necesita root para funcionar
sudo su|su
# Apaga la memoria swap, disminuyendo su tamaño hasta cero, y moviendo en el proceso el contenido a la memoria RAM
# Para ello, debe haber espacio suficiente en la RAM.
# luego de reducirla a cero (swapoff) la activa de nuevo a su valor total (de la partición swap) iniciando vacía.
# con esto se optimiza el uso de memoria disminuyendo el intercambio swap-ram cuando el contenido de swap queda estancado
# teniendo gran cantidad de RAM vacía.
# fuente http://geekland.eu/optimizar-el-uso-de-la-memoria-swap/
# @copyleft (basado en la fuente mencionada)


swapiness=`cat /proc/sys/vm/swappiness`
echo "Info valor del swapiness:$swapiness"

echo "Estado inicial de la memoria..."
free

# Limpiar la cache admite opciones 0 a 3
# 0 no limpia cache
# 1 estamos forzando a nuestro kernel a liberar la pagecache.
# 2 estamos forzando a nuestro kernel a liberar los inodos y dentries.
# 3 estamos forzando a nuestro kernel a liberar la pagecache, los inodos y las dentries.
# sync: Con el comando sync aseguramos que solo se liberen de la cache los objetos que no estamos usando actualmente.
# Por lo tanto a priori no hay peligro de cuelgues ni estabilidad en realizar esta operación.
echo “Limpiando la caché~ “;
sync ; echo 3 > /proc/sys/vm/drop_caches

echo "Liberado de la memoria Swap (moviendola a la memoria RAM)"
swapoff -a && echo "Activando la memoria Swap liberada" ; sudo swapon -a
echo "Estado actual post liberación..."
free
#configuracion para usar mas la swap 
echo "Introduzca un valor para el uso de la swap(de 10 a 80): \t"
read swap
until $swap<10&&$swap>80
  do
    echo "el valor introducido no es valido, introduce de nuevo un valor entre 10 y 80 \t"
    read swap
  done
sysctl -w vm.swappiness=$swap
