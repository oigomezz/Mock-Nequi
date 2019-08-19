require_relative 'connection.rb'
require_relative 'create.rb'
require_relative 'login.rb'
require_relative 'query.rb'
require_relative 'modifier.rb'
require_relative 'user.rb'
require_relative 'validador.rb'

class Menu

	def initialize(user)
		@user_name = user.name
		@creacion = Creation.new(user)
		@consulta = Query.new(user)
		@modificador = Modifier.new(user)

	end

	def main_menu(user)
		while true
			system("clear")
		  	puts"---------------------------------Mock-Nequi------------------------------------",
		  		"",
				"Bienvenido  #{@user_name}",
				"",
				"Saldo disponible en la cuenta: #{@consulta.available_balance_query}",
				"En colchon: #{@consulta.mattress_money_query}",
				"",
				"¿Que deseas hacer?",
				"1. Agregar dinero a la cuenta principal",
				"2. Retirar dinero de la cuenta principal",
				"3. Enviar dinero por email a otro usuario",
				"4. Ver transacciones",
				"5. Colchon",
				"6. Bolsillos",
				"7. Metas",
				"8. Cerrar sesion"

			option = gets.chomp
			case option
			when "1"
				system("clear")
				puts "¿Cuanto dinero desea agregar?"
				value = gets.chomp.to_i
				validacion = Validator.new()
				if validacion.positive_number(value)
					@modificador.add_money_account(value)
					puts "Nuevo saldo: $ #{@consulta.available_balance_query}"
				else
					puts "Monto Invalido"
				end

				puts "Pulse enter para volver"
				option = gets.chomp

			when "2"
				system("clear")
				puts "¿Cuanto dinero desea retirar?"
				value = gets.chomp.to_i
				validacion = Validator.new()
				if validacion.positive_number(value)
					@modificador.withdraw_money(value)
					puts "Nuevo saldo: $ #{@consulta.available_balance_query}"
				else
					puts "Monto Invalido"
				end

				puts "Pulse enter para volver"
				option = gets.chomp

			when "3"
				system("clear")
				puts "Ingrese el correo del usuario destino"
				email = gets.chomp
				puts "Ingrese valor a depositar"
				value = gets.chomp.to_i
				validacion = Validator.new()
				if validacion.positive_number(value)
					@modificador.send_money(email,value)
					puts "Nuevo saldo: $ #{@consulta.available_balance_query}"
				else
					puts "Monto Invalido"
				end

				puts "Pulse enter para volver"
				option = gets.chomp

			when "4"
				system("clear")
				puts "Ingrese el numero de transacciones"
				number = gets.chomp
				transactions_menu(number)

			when "5"
				mattress_menu()

			when "6"
				pockets_menu()

			when "7"
				goals_menu()

			when "8"

				user.name=nil
				user.password=nil
				user.email=nil
				break
			else
				puts "Opcion incorrecta, vuelva a intentar","Pulse enter para volver"
				option = gets.chomp
			end
		end
	end

	def transactions_menu(number)

		while true

			listado = @consulta.transactions_query(number)
			option = "2"
			if  listado != nil
				puts "Listado de las ultimas #{number} Tansacciones"
				option = "1"

			else
				puts "No hay transacciones"
				option = "2"
			end

			case option
			when "1"
				puts "+------------+---------------------------------------------------+------------+",
					 "| Fecha      |  Descripcion                                      | Valor      |",
					 "+------------+---------------------------------------------------+------------+",
					  listado,
					  "+------------+---------------------------------------------------+------------+"

				puts "Pulse enter para volver"
				option = gets.chomp
				break

			when "2"
				break
			end
		end
	end


	def mattress_menu
		while true
			system("clear")
			puts"---------------------------------Mock-Nequi------------------------------------",
				"",
				"Guardado en colchon: #{@consulta.mattress_money_query}",
				"",
				"¿Que deseas hacer?",
				"1. Agregar dinero disponible al colchon",
				"2. Enviar dinero a la cuenta principal",
				"3. Volver"

			option = gets.chomp
			case option
			when "1"
				system("clear")
				puts "¿Cuanto dinero desea ingresar al colchon?"
				value = gets.chomp.to_i
				validacion = Validator.new()
				if validacion.positive_number(value)
					@modificador.add_money_mattress(value)
					puts "Nuevo saldo en el colchon: $ #{@consulta.mattress_money_query}"
				else
					puts "Monto Invalido"
				end

				puts "Pulse enter para volver"
				option = gets.chomp

			when "2"
				system("clear")
				puts "¿Cuanto desea sacar del colchon?"
				value = gets.chomp.to_i
				validacion = Validator.new()
				if validacion.positive_number(value)
					@modificador.withdraw_money_mattress(value)
					puts "Nuevo saldo en el colchon: $ #{@consulta.mattress_money_query}"
				else
					puts "Monto Invalido"
				end

				puts "Pulse enter para volver"
				option = gets.chomp

			when "3"
				break
			else
				puts "Opcion incorrecta, vuelva a intentar","Pulse enter para volver"
				option = gets.chomp
			end
		end
	end

	def pockets_menu
		while true
			system("clear")
			puts"---------------------------------Mock-Nequi------------------------------------",
				"",
				"¿Que deseas hacer?",
				"1. Ver lista de bolsillos",
				"2. Crear bolsillo",
				"3. Eliminar bolsillo",
				"4. Agregar dinero a un bolsillo",
				"5. Retirar dinero de un bolsillo",
				"6. Volver"

			option = gets.chomp
			case option
			when "1"
				system("clear")
				puts "+----------------------------------------------------------------+------------+",
					 "|Nombre del bolsillo                                             | Valor      |",
					 "+----------------------------------------------------------------+------------+",
					 "#{@consulta.pockets_list}",
					 "+----------------------------------------------------------------+------------+"
				puts "Pulse enter para volver"
				option = gets.chomp

			when "2"
				system("clear")
				puts "Nombre del bolsillo"
				pocket_name = gets.chomp
				validacion = Validator.new()
				if validacion.pocket_name_validator(pocket_name)
					@creacion.create_pocket(pocket_name)
					puts "Bolsillo creado exitosamente"
				else
					puts "Nombre invalido"
					puts "Pulse enter para volver"
					option = gets.chomp
				end



			when "3"
				system("clear")
				puts "Ingrese el nombre del bolsillo que desea eliminar"
				pocket_name = gets.chomp
				@creacion.delete_pocket(pocket_name)
				puts "Bolsillo eliminado exitosamente", "Pulse enter para volver"
				option = gets.chomp

			when "4"
				system("clear")
				puts "Ingrese el nombre del bolsillo que desea agregarle dinero"
				pocket_name = gets.chomp
				puts "Ingrese la cantidad de dinero"
				value = gets.chomp.to_i
				validacion = Validator.new()
				if validacion.positive_number(value)
					@modificador.add_money_pocket(pocket_name,value)

				else
					puts "Monto Invalido"
				end

				puts "Pulse enter para volver"
				option = gets.chomp

			when "5"
				system("clear")
				puts "Ingrese el nombre del bolsillo que desea retirarle dinero"
				pocket_name = gets.chomp
				puts "Ingrese la cantidad de dinero"
				value = gets.chomp.to_i
				validacion = Validator.new()
				if validacion.positive_number(value)
					@modificador.withdraw_money_pocket(pocket_name,value)

				else
					puts "Monto Invalido"
				end

				puts "Pulse enter para volver"
				option = gets.chomp

			when "6"
				break
			else
				puts "Opcion incorrecta, vuelva a intentar","Pulse enter para volver"
				option = gets.chomp
			end
		end
	end

	def goals_menu
		while true
			system("clear")
			puts"---------------------------------Mock-Nequi------------------------------------",
				"",
				"¿Que deseas hacer?",
				"1. Ver lista de metas",
				"2. Crear meta",
				"3. Cerrar meta",
				"4. Agregar dinero a una meta",
				"5. Volver"

			option = gets.chomp
			case option
			when "1"
				system("clear")
				puts "+--------------------------------+-------------+-------------+------------+---+",
					 "|Nombre                          | Abonado     | Total       |Fecha Limite|   |",
					 "+--------------------------------+-------------+-------------+------------+---+",
					 "#{@consulta.goals_list}",
					 "+--------------------------------+-------------+-------------+------------+---+"

				puts "Pulse enter para volver"
				option = gets.chomp

			when "2"
				system("clear")
				puts "Ingrese el nombre de la meta"
				goal_name = gets.chomp

				validacion = Validator.new()
				if validacion.goal_name_validator(goal_name)
					puts "Ingrese el valor de la meta"
					value = gets.chomp.to_i
					if validacion.positive_number(value)
						puts "Fecha limite", "Por favor ingrese el año: "
						year = gets.chomp.to_i
						puts "Por favor ingrese el mes: "
						month = gets.chomp.to_i
						puts "Por favor ingrese el dia: "
						day = gets.chomp.to_i
						if validacion.date(year,month,day)
							if month < 10
								mes = "0" + month.to_s
							else
								mes = month.to_s
							end
							if day < 10
								dia = "0" + day.to_s
							else
								dia = day.to_s
							end
							goal_date = year.to_s + mes + dia
							@creacion.create_goals(goal_name,goal_date,value)
							puts "Meta creada exitosamente"
						else
							puts "Fecha Invalido"
						end
					else
						puts "Monto Invalido"
					end
				else
					puts "Nombre invalido"
				end
				puts "Pulse enter para volver"
				option = gets.chomp


			when "3"
				system("clear")
				puts "Ingrese el nombre de la meta que desea cerrar"
				toclose = gets.chomp
				@creacion.delete_goals(toclose)

				puts "Pulse enter para volver"
				option = gets.chomp

			when "4"
				system("clear")
				puts "Ingrese el nombre de la meta"
				goal_name = gets.chomp
				puts "Ingrese valor a depositar"
				value = gets.chomp.to_i
				validacion = Validator.new()
				if validacion.positive_number(value)
					@modificador.add_money_goal(goal_name,value)
				else
					puts "Monto Invalido"
				end

				puts "Pulse enter para volver"
				option = gets.chomp

			when "5"
				break
			else
				puts "Opcion incorrecta, vuelva a intentar","Pulse enter para volver"
				option = gets.chomp
			end
		end
	end
end
