require_relative 'connection.rb'
require_relative 'login.rb'

class Query

	def initialize(user_name, password, email)
		@user_name= user_name
		@password = password
		@email = email
		@db_connection = DbConnection.new()
	end

	def total_balance_query(id_user)
		result = @db_connection.client.query("select total from accounts where id = #{id_user};")
		total = nil
		result.each do |row|
			total = row["total"]
		end 
		return total

	end

	def available_balance_query(id_user)
		result = @db_connection.client.query("select disponible from accounts where id = #{id_user};")
		disponible = nil
		result.each do |row|
			disponible = row["disponible"]
		end 
		return disponible	

	end
	
	def transactions_query(number)

	end
	
	def mattress_money_query(id_user)
		result = @db_connection.client.query("select mattress from accounts where id = #{id_user};")
		mattress = nil
		result.each do |row|
			mattress = row["mattress"]
		end 

		return mattress

	end
	
	def pockets_list(accounts_id )
		result = @db_connection.client.query("select name, pocketMoney from pockets where accounts_id = #{accounts_id };")
		result.each do |row|
			puts row
		end 

	end
	
	def goals_list(accounts_id )
		result = @db_connection.client.query("select name, date, savedMoney, totalAmount, from goals where accounts_id = #{accounts_id };")
		result.each do |row|
			puts row
		end 

	end
		
end
