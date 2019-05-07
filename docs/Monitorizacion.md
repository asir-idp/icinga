## Monitorización

**Icinga2** soporta distintos tipos de monitorización:

* Maestro único
* Maestro - clientes
* Maestro - satélite - clientes

Y cada uno de estos tipos soporta varios modos de funcionamiento.

En nuestro caso hemos elegido el tipo más común que es el de ***Maestro único***. En este modo, un maestro Icinga comprueba los servicios remotos en los nodos de la red.

Para configurar este modo editaremos el fichero `/etc/icinga2/conf.d/hosts.conf` y añadiremos los *hosts* que queremos monitorizar, como por ejemplo:

```
object Host "NombreNodo" {
    import "generic-host"
    address = "192.168.0.5"
}
```

![](screenshots/hosts.png)

Y ahora editamos el fichero `/etc/icinga2/conf.d/services.conf` para añadir los *servicios* que queremos monitorizar, como por ejemplo:

```
object Service "ssh" {
    host_name = "NombreNodo"
    check_command = "ssh"
}
```
Con este ejemplo, hemos usado el módulo `ssh` de Icinga para monitorizar el puerto 22 de ssh así como obtener información básica del servicio en este host en concreto.

Si quisieramos que ese servicio se comprobase en todos los hosts, utilizariamos la siguiente sintaxis:

```
apply Service "ssh" {
    check_command = "ssh"
    assign where host.address
}
```

Con este ejemplo hemos utilizado la directiva `apply` para monitorizar el servicio `ssh` en todos los hosts que tengan definida una dirección IP en nuestra configuración.

Repetiremos este paso tantas veces como servicios queremos monitorizar.

![](screenshots/hosts1.png)

![](screenshots/hosts2.png)

[Volver](home.md)