require_relative 'connection.rb'
require_relative 'user.rb'
require_relative 'login.rb'
require 'digest'

class Creation

	def initialize(user)
		@user_name= user.name
		@password =  Digest::SHA1.hexdigest user.password
		@email = user.email

		@sesion=Login.new(user)
		@db_connection = @sesion.db_connection
		@id_user = @sesion.id_current_user

	end

	def register_user
		current_user = User.new(@user_name, @email, @password)
		user_exists = @db_connection.client.query("select id from users where mail = \'#{@email}\'", :symbolize_keys => true)
		id_count=nil
		user_exists.each do |i|
			id_count= i[:id]
		end

		if id_count ==nil
			succeful_access = @db_connection.client.query("insert into accounts (disponible,mattress, total) values (0,0,0);", :symbolize_keys => true)
			result = @db_connection.client.query("select id from accounts order by id desc limit 1;", :symbolize_keys => true)
			id_count=nil
			result.each do |row|
				id_count= row[:id]
			end

			succeful_access = @db_connection.client.query("insert into users(mail, password, user_name ,accounts_id ) values (\"#{current_user.email}\",\"#{ current_user.password}\",\"#{ current_user.name}\", #{id_count});", :symbolize_keys => true)
			return true
		else
			puts "el email ya se encuntra registrado"
			return false
		end

	end

	def create_pocket(pocket_name)

		result = @db_connection.client.query("select accounts_id from users where id = #{@id_user} ;", :symbolize_keys => true)
		accounts_id=nil
		result.each do |row|
			accounts_id=row[:accounts_id]
		end

		succeful_access = @db_connection.client.query("insert into pockets(pocketMoney, name, accounts_id ) values (0.0, \"#{pocket_name}\",  #{accounts_id});", :symbolize_keys => true)

	end

	def delete_pocket(name_pocket)

		result = @db_connection.client.query("select accounts_id from users where id = #{@id_user};", :symbolize_keys => true)
		accounts_id=nil
		result.each do |row|
			accounts_id=row[:accounts_id]
		end

		result = @db_connection.client.query("select id from pockets where name = \'#{name_pocket}\' and accounts_id = #{accounts_id};", :symbolize_keys => true)
		id_pocket=nil
		result.each do |row|
			id_pocket= row[:id]
		end

		result = @db_connection.client.query("select pocketMoney from pockets where id = \'#{id_pocket}\'", :symbolize_keys => true)
		pocketMoney=nil
		result.each do |row|
			pocketMoney= row[:pocketMoney]
		end

		if id_pocket.class == Integer
			result = @db_connection.client.query("UPDATE accounts SET disponible = disponible + #{pocketMoney} WHERE id = #{accounts_id};", :symbolize_keys => true)
			result = @db_connection.client.query("delete from pockets where id = \'#{id_pocket}\' limit 1", :symbolize_keys => true)
		else
			puts "bolsillo no encontrado"
		end

	end

	def create_goals(name, date, totalAmount)

		result = @db_connection.client.query("select accounts_id from users where id = #{@id_user} ;", :symbolize_keys => true)
		accounts_id=nil

		result.each do |row|
			accounts_id=row[:accounts_id]
		end
		result = @db_connection.client.query("insert into goals (name, date, totalAmount, fulfilled, savedMoney, accounts_id ) values (\'#{name}\', \'#{date}\', #{totalAmount}, 0, 0, #{accounts_id});", :symbolize_keys => true)
	end

	def delete_goals(goal_name)

		result = @db_connection.client.query("select accounts_id from users where id = #{@id_user};", :symbolize_keys => true)
		accounts_id=nil
		result.each do |row|
			accounts_id=row[:accounts_id]
		end

		result = @db_connection.client.query("select id from goals where name = \'#{goal_name}\' and accounts_id = #{accounts_id};", :symbolize_keys => true)
		id_goal=nil
		result.each do |row|
			id_goal= row[:id]
		end

		result = @db_connection.client.query("select savedMoney from goals where id = \'#{id_goal}\'", :symbolize_keys => true)
		savedMoney=nil
		result.each do |row|
			savedMoney= row[:savedMoney]
			puts "Dinero de la meta", savedMoney
		end

		if id_goal.class == Integer
			result = @db_connection.client.query("UPDATE accounts SET disponible = disponible + #{savedMoney} WHERE id = #{accounts_id};", :symbolize_keys => true)
			result = @db_connection.client.query("delete from goals where id = \'#{id_goal}\' limit 1", :symbolize_keys => true)
		else
			puts "Meta no encontrada"
		end

	end

end
