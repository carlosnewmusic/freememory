# Podemos crear un archivo php llamado limpiame.php con el siguiente contenido:

#!/usr/bin/php -q
/proc/sys/vm/drop_caches”);
sleep(60);
}
?>

Así ejecutaría el comando de limpieza cada 60 minutos.

# Para llamar al archivo limpiame.php y que quede funcionando en segundo plano se llamaría así:
# nohup ./limpiame.php > /dev/null

# y si quieres comprobar que este funcionando:
# ps -A | grep limpiame
# y ahí deberá aparecer el proceso.

# Cabe añadir que este archivo php deberá tener permisos de ejecución y ser ejecutado por el usuario root.

# Igualmente deberás tener instalado el Lenguaje php
# (“sudo yum install php”)
