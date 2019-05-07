## Instalación en Ubuntu 18.04 Bionic

1. ***Instalar el repositorio de Icinga2***:

    ```bash
    sudo apt-get install apt-transport-https

    sudo wget -qO - https://packages.icinga.com/icinga.key | sudo apt-key add -

    sudo add-apt-repository "deb https://packages.icinga.com/ubuntu icinga-bionic main"
    ```

2. ***Instalar Icinga2***:

    ```bash
    sudo apt-get update

    sudo apt-get install icinga2 monitoring-plugins
    ```

3. ***Habilitar acceso remoto a Icinga2***:

    ```bash
    sudo icinga2 api setup
    ```

    *Una vez inicializado el acceso remoto debemos de añadir un usuario en el fichero `/etc/icinga2/conf.d/api-users.conf`:*

    ```
    object ApiUser "api_user" {
        password = "12345678"
        permissions = [ "*" ]
    }
    ```

    *Ahora reiniciaremos el servicio para aplicar los cambios efectuados:*

    ```bash
    sudo systemctl restart icinga2
    ```

4. ***Interfaz web:***

    *Para instalar la interfaz web, primero debemos de instalar el driver de MYSQL para Icinga2.*

    4.1. **Instalación driver mysql para Icinga2:**
    
    ```bash
    sudo apt-get install mysql-client mysql-server icinga2-ido-mysql
    
    sudo mysql_secure_installation
    ```
    
    4.2. **Creación de base de datos:**
    
    ```
    mysql -u root -p

    CREATE DATABASE icinga2;
    GRANT ALL ON icinga2.* TO 'icinga2'@'localhost' IDENTIFIED BY 'Icinga_2';
    quit
    ```
    ```
    mysql -u root -p icinga2 < /usr/share/icinga2-ido-mysql/schema/mysql.sql
    ```
    
    4.3. **Creación de usuario para el módulo:**
    
    Editamos el fichero `/etc/icinga2/features-available/ido-mysql.conf`:
    
    ```
    object IdoMysqlConnection "ido-mysql-2" {
        user = "icinga2",
        password = "Icinga_2",
        host = "localhost",
        database = "icinga2"
    }
    ```
    
    4.4. **Habilitar módulo de MYSQL:**
    
    ```bash
    sudo icinga2 feature enable ido-mysql
    ```
    
    *Ahora reiniciaremos el servicio para aplicar los cambios efectuados:*

    ```bash
    sudo systemctl restart icinga2
    ```
    
    4.5. **Instalación de la interfaz web:**
    
    ```bash
    sudo apt-get install apache2 icingaweb2 icingacli libapache2-mod-php
    ```
    
    4.6. **Creación de base de datos para la interfaz:**
    
    ```
    mysql -u root -p

    CREATE DATABASE icingaweb2;
    GRANT ALL ON icingaweb2.* TO 'icingaweb2'@'localhost' IDENTIFIED BY 'Icingaweb_2';
    quit
    ```
    
    4.7. **Generar token de configuración:**
    
    ```bash
    sudo icingacli setup token create
    ```
    
    4.8. **Reinicio del servicio apache2**

    ```bash
    sudo systemctl restart apache2
    ```
    
[Volver](..)