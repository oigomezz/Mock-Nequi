require_relative 'connection.rb'
require_relative 'user.rb'
require_relative 'login.rb'

class Modifier

	def initialize(user)
		@email = user.email
		@password = user.password

		@sesion=Login.new(user)
		@db_connection = @sesion.db_connection
		@id_user = @sesion.id_current_user
	end

	def add_money_account(amount)

		result = @db_connection.client.query("select accounts_id from users where id = #{@id_user};", :symbolize_keys => true)
		accounts_id=nil
		result.each do |row|
			accounts_id= row[:accounts_id]
		end

		result = @db_connection.client.query("UPDATE accounts SET disponible = disponible + #{amount} WHERE id = #{accounts_id};", :symbolize_keys => true)

		 #transaction(from, to, description, value)
		 transaction(@id_user, @id_user, "consignacion", amount)
	end

	def withdraw_money(amount)

		result = @db_connection.client.query("select accounts_id from users where id = #{@id_user};", :symbolize_keys => true)
		accounts_id=nil
		result.each do |row|
			accounts_id= row[:accounts_id]
		end

		result = @db_connection.client.query("select disponible from accounts where id = #{accounts_id};", :symbolize_keys => true)
		disponible=nil
		result.each do |row|
			disponible= row[:disponible]
		end
		if amount <= disponible
			result = @db_connection.client.query("UPDATE accounts SET disponible = disponible - #{amount} WHERE id = #{accounts_id};", :symbolize_keys => true)
			#transaction(from, to, description, value)
			transaction(@id_user, @id_user, "retiro dinero", amount)
		else
			puts "transaccion invalida, NO MONEY"
		end

	end

	def send_money(send_to, amount)

		result = @db_connection.client.query("select accounts_id from users where id = #{@id_user};", :symbolize_keys => true)
		accounts_id=nil
		result.each do |row|
			accounts_id= row[:accounts_id]
		end

		result = @db_connection.client.query("select disponible from accounts where id = #{accounts_id};", :symbolize_keys => true)
		disponible=0
		result.each do |row|
			disponible= row[:disponible]
		end

		result = @db_connection.client.query("select accounts_id from users where mail =\'#{send_to}\';", :symbolize_keys => true)
		send=""
		result.each do |row|
			send= row[:accounts_id]
		end

		if send== ""
			puts "correo invalido"
		else
			if disponible >= amount
				result = @db_connection.client.query("UPDATE accounts SET disponible = disponible - #{amount} WHERE id = #{accounts_id};", :symbolize_keys => true)
				result = @db_connection.client.query("UPDATE accounts SET disponible = disponible + #{amount} WHERE id = #{send};", :symbolize_keys => true)
				#transaction(from, to, description, value)
				transaction(@id_user, send, "envio de dinero a #{send_to}", amount)
			else
				puts "transaccion invalida, NO MONEY"
			end
		end
	end

	def add_money_mattress(amount)

		result = @db_connection.client.query("select accounts_id from users where id = #{@id_user};", :symbolize_keys => true)
		accounts_id=nil
		result.each do |row|
			accounts_id= row[:accounts_id]

		end

		result = @db_connection.client.query("select disponible from accounts where id = #{accounts_id};", :symbolize_keys => true)
		disponible=0
		result.each do |row|
			disponible= row[:disponible]
		end

		if disponible >= amount
			result = @db_connection.client.query("UPDATE accounts SET disponible = disponible - #{amount} WHERE id = #{accounts_id};", :symbolize_keys => true)
			result = @db_connection.client.query("UPDATE accounts SET mattress = mattress + #{amount} WHERE id = #{accounts_id};", :symbolize_keys => true)
			#transaction(from, to, description, value)
			transaction(@id_user, @id_user, "envio a colchon", amount)
		else
			puts "transaccion invalida, NO MONEY"
		end
	end

	def withdraw_money_mattress(amount)

		result = @db_connection.client.query("select accounts_id from users where id = #{@id_user};", :symbolize_keys => true)
		accounts_id=nil
		result.each do |row|
			accounts_id= row[:accounts_id]
		end

		result = @db_connection.client.query("select mattress from accounts where id = #{accounts_id};", :symbolize_keys => true)
		disponible=0
		result.each do |row|
			disponible= row[:mattress]
		end

		if disponible >= amount
			result = @db_connection.client.query("UPDATE accounts SET disponible = disponible + #{amount} WHERE id = #{accounts_id};", :symbolize_keys => true)
			result = @db_connection.client.query("UPDATE accounts SET mattress = mattress - #{amount} WHERE id = #{accounts_id};", :symbolize_keys => true)
			#transaction(from, to, description, value)
 		 transaction(@id_user, @id_user, "retiro de colchon", amount)
		else
			puts "transaccion invalida, NO MONEY"
		end
	end

	def add_money_pocket(nombre_pocket, amount)

		result = @db_connection.client.query("select accounts_id from users where id = #{@id_user};", :symbolize_keys => true)
		accounts_id=nil
		result.each do |row|
			accounts_id= row[:accounts_id]
		end

		result = @db_connection.client.query("select id from pockets where name = \'#{nombre_pocket}\';", :symbolize_keys => true)
		id_pocket=nil
		result.each do |row|
			id_pocket= row[:id]
		end

		if id_pocket == nil
			puts "bolsillo no encontrado"
		else

			result = @db_connection.client.query("select disponible from accounts where id = #{accounts_id};", :symbolize_keys => true)
			disponible=0
			result.each do |row|
				disponible= row[:disponible]
			end

			if disponible >= amount
				result = @db_connection.client.query("UPDATE accounts SET disponible = disponible - #{amount} WHERE id = #{accounts_id};", :symbolize_keys => true)
				result = @db_connection.client.query("UPDATE pockets SET pocketMoney = pocketMoney + #{amount} WHERE id = #{id_pocket};", :symbolize_keys => true)
				#transaction(from, to, description, value)
			  	transaction(@id_user, @id_user, "envio dinero al bolsillo #{nombre_pocket}", amount)
				puts "transaccion exitosa"
			else
				puts "transaccion invalida, NO MONEY"
			end
		end

	end

	def withdraw_money_pocket(nombre_pocket, amount)


		result = @db_connection.client.query("select accounts_id from users where id = #{@id_user};", :symbolize_keys => true)
		accounts_id=nil
		result.each do |row|
			accounts_id= row[:accounts_id]
		end

		result = @db_connection.client.query("select id from pockets where name = \'#{nombre_pocket}\';", :symbolize_keys => true)
		id_pocket=nil
		result.each do |row|
			id_pocket= row[:id]
		end

		if id_pocket == nil
			puts "bolsillo no encontrado"
		else
			result = @db_connection.client.query("select pocketMoney from pockets where id = #{id_pocket};", :symbolize_keys => true)
			disponible=0
			result.each do |row|
				disponible= row[:pocketMoney]
			end

			if disponible >= amount
				result = @db_connection.client.query("UPDATE accounts SET disponible = disponible + #{amount} WHERE id = #{accounts_id};", :symbolize_keys => true)
				result = @db_connection.client.query("UPDATE pockets SET pocketMoney = pocketMoney - #{amount} WHERE id = #{id_pocket};", :symbolize_keys => true)

				#transaction(from, to, description, value)
				transaction(@id_user, @id_user, "retiro dinero del bolsillo #{nombre_pocket}", amount)
				puts "transaccion exitosa"
			else
				puts "transaccion invalida, NO MONEY"
			end
		end

	end

	def send_money_pocket(nombre_pocket, amount)
		result = @db_connection.client.query("select accounts_id from users where id = #{@id_user};", :symbolize_keys => true)
		accounts_id=nil
		result.each do |row|
			accounts_id= row[:accounts_id]
		end

		result = @db_connection.client.query("select id from pockets where name = \'#{nombre_pocket}\';", :symbolize_keys => true)
		id_pocket=nil
		result.each do |row|
			id_pocket= row[:id]
		end

		result = @db_connection.client.query("select pocketMoney from pockets where id = #{id_pocket};", :symbolize_keys => true)
		disponible=0
		result.each do |row|
			disponible= row[:pocketMoney]
		end

		if disponible >= amount
			result = @db_connection.client.query("UPDATE accounts SET disponible = disponible + #{amount} WHERE id = #{accounts_id};", :symbolize_keys => true)
			result = @db_connection.client.query("UPDATE pockets SET pocketMoney = pocketMoney - #{amount} WHERE id = #{id_pocket};", :symbolize_keys => true)
			#transaction(from, to, description, value)
 		 transaction(@id_user, @id_user, "envio desde el bolsillo #{nombre_pocket}", amount)
		else
			puts "transaccion invalida, NO MONEY"
		end
	end

	def add_money_goal(name_goal,amount)

		result = @db_connection.client.query("select accounts_id from users where id = #{@id_user};", :symbolize_keys => true)
		accounts_id=nil
		result.each do |row|
			accounts_id= row[:accounts_id]
		end

		result = @db_connection.client.query("select id from goals where name = \'#{name_goal}\';", :symbolize_keys => true)
		id_goal=nil
		result.each do |row|
			id_goal= row[:id]
		end

		if id_goal.class == Integer
			result = @db_connection.client.query("select disponible from accounts where id = #{accounts_id};", :symbolize_keys => true)
			disponible=0
			result.each do |row|
				disponible= row[:disponible]
			end

			if disponible >= amount

				result = @db_connection.client.query("select fulfilled from goals where accounts_id = #{accounts_id};", :symbolize_keys => true)
				fulfilled=0
				result.each do |row|
					fulfilled= row[:fulfilled]
				end

				if fulfilled == "0"
					result = @db_connection.client.query("UPDATE accounts SET disponible = disponible - #{amount} WHERE id = #{accounts_id};", :symbolize_keys => true)
					result = @db_connection.client.query("UPDATE goals SET savedMoney = savedMoney + #{amount} WHERE id = #{id_goal};", :symbolize_keys => true)
					#transaction(from, to, description, value)
		 		 	transaction(@id_user, @id_user, "envio de dinero a la meta #{name_goal}", amount)

					result = @db_connection.client.query("select savedMoney from goals where accounts_id = #{accounts_id};", :symbolize_keys => true)
					savedMoney=0
					result.each do |row|
						savedMoney= row[:savedMoney]
					end

					result = @db_connection.client.query("select totalAmount from goals where accounts_id = #{accounts_id};", :symbolize_keys => true)
					totalAmount=0
					result.each do |row|
						totalAmount= row[:totalAmount]
					end

					if savedMoney >= totalAmount
						result = @db_connection.client.query("UPDATE goals SET fulfilled = 1  WHERE id = #{id_goal};", :symbolize_keys => true)
					end

				else
					puts "transaccion invalida, meta alcanzada"
				end

			else
				puts "transaccion invalida, NO MONEY"
			end
		else
			puts "Meta no existente"
		end

	end

	def transaction(from, to, description, value)
		if from == to
			result = @db_connection.client.query("insert into transactions (`from`, `to`, `description`, `value`, `date`, `accounts_id`) values (#{from},#{to},\'#{description}\',#{value},now(), #{from});", :symbolize_keys => true)
		else
			result = @db_connection.client.query("insert into transactions (`from`, `to`, `description`, `value`, `date`, `accounts_id`) values (#{from},#{to},\'#{description}\',#{value},now(), #{from});", :symbolize_keys => true)
			result = @db_connection.client.query("insert into transactions (`from`, `to`, `description`, `value`, `date`, `accounts_id`) values (#{from},#{to},\'#{description}\',#{value},now(), #{to});", :symbolize_keys => true)
		end
	end
end
