require 'io/console'
require_relative 'connection.rb'
require_relative 'create.rb'
require_relative "login.rb"
require_relative "menu.rb"


while true
    system("clear")
    puts "---------------------------------Mock-Nequi------------------------------------",
         "Usted desea: ",
         "1. Regiatrarse" ,
         "2. Iniciar Sesion" ,
         "3. Salir del programa"
    option = gets.chomp

    case option
    when "1"
        system("clear")
        puts "Ingrese su nombre:"
        user_name = gets.chomp
        puts "Ingrese su correo electronico:"
        email = gets.chomp
        puts "Ingrese contraseña: "
        password = STDIN.noecho(&:gets).chomp
        usuario = User.new(user_name,email,password)
        creacion = Creation.new(usuario)
        succeful_register = creacion.register_user
        if succeful_register
          mnnu = Menu.new(usuario)
          mnnu.main_menu(usuario)
        else
          puts "Pulse enter para volver"
          option = gets.chomp
        end


    when "2"
        system("clear")
        puts "Ingrese su correo electronico:"
        email = gets.chomp
        puts "Ingrese contraseña: "
        password = STDIN.noecho(&:gets).chomp
        user = User.new(email,email,password)
        usuario = Login.new(user)
        usuario.current_user_is_logged(user)
    when "3"
        system("clear")
        puts "Saliendo del programa..."
        break
    else
        puts "Opcion incorrecta, vuelva a intentar","Pulse enter para volver"
		option = gets.chomp
    end
end
