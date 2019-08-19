# Mock-Nequi

Esta aplicacion fue desarrollada como un sistema basado en consola que permite:

- Registrar nuevos usuarios con su nombre, email y password.
- Consultar el saldo de disponible en su cuenta.
- Enviar dinero a otro usuario a través de su email, desde cualquier cuenta de ahorros.
- Consultar sus últimas N transacciones.
- Colchon: lugar donde el usuario podra ahorrar dinero.
- Bolsillos: subcuentas que el usuario podra usar para diferentes propositos.
- Metas: subcuentas en las que le usuario podra ahorrar dinero para un proposito espesifico.

Se utiliza la gema https://www.rubydoc.info/gems/mysql2/0.5.2 para conectarse a la base de datos desde ruby.

## Uso

1. Correr el script database.sql en un servidor Mysql 5.x para crear la base de datos necesaria.
2. Modificar las propiedades de conexion del servidor Mysql en el archivo connection.rb 
3. Instalar ruby 2.5.x y correr el programa Mock-Nequi.rb

Colaboradores
- Oscar Gomez
- Yonatan Cuervo


