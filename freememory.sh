#!/bin/bash

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
sudo swapoff -a && echo "Activando la memoria Swap liberada" ; sudo swapon -a
echo "Estado actual post liberación..."
free
