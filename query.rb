require_relative 'connection.rb'
require_relative 'login.rb'

class Query

	attr_accessor :email, :password, :db_connection, :sesion, :id_user
	def initialize(user)

		@email = user.email
		@password = Digest::SHA1.hexdigest user.password

		@sesion=Login.new(user)
		@db_connection = @sesion.db_connection
		@id_user = @sesion.id_current_user

	end

	def total_balance_query
		result = @db_connection.client.query("select a.total from accounts a join users u on u.accounts_id = a.id where u.id= #{@id_user};")
		total = 0
		result.each do |row|
			total = row["total"]
		end
		return total

	end

	def available_balance_query
		result = @db_connection.client.query("select a.disponible from accounts a join users u on u.accounts_id = a.id where u.id= #{@id_user};")
		disponible = 0
		result.each do |row|
			disponible = row["disponible"]
		end
		return disponible

	end

	def transactions_query(number)
		result = @db_connection.client.query("select accounts_id from users where id = #{@id_user};", :symbolize_keys => true)
		accounts_id=nil
		result.each do |row|
			accounts_id= row[:accounts_id]
		end

		list = ""
		result = @db_connection.client.query("select * from transactions where accounts_id = #{accounts_id} order by date desc limit #{number};")
		result.each do |row|
			list = list + "| #{row["date"]} | #{row["description"].ljust(49)} | #{row["value"].to_s.rjust(10)} | \n"
		end

		return list
	end

	def mattress_money_query
		result = @db_connection.client.query("select a.mattress from accounts a join users u on u.accounts_id = a.id where u.id= #{@id_user};")
		mattress = 0
		result.each do |row|
			mattress = row["mattress"]
		end
		return mattress

	end

	def pockets_list
		result = @db_connection.client.query("select accounts_id from users where id = #{@id_user};", :symbolize_keys => true)
		accounts_id=nil
		result.each do |row|
			accounts_id= row[:accounts_id]
		end
		result = @db_connection.client.query("select name, pocketMoney from pockets where accounts_id = #{accounts_id};")
		list = ""
		result.each do |row|
			list = list + "| #{row["name"].ljust(62)} | #{row["pocketMoney"].to_s.rjust(10)} | \n"
		end
		return list

	end

	def goals_list
		result = @db_connection.client.query("select accounts_id from users where id = #{@id_user};", :symbolize_keys => true)
		accounts_id=nil
		result.each do |row|
			accounts_id= row[:accounts_id]
		end
		result = @db_connection.client.query("select name, date, savedMoney, totalAmount, fulfilled from goals where accounts_id = #{accounts_id};")
		list = ""
		result.each do |row|
			list = list + "| #{row["name"].ljust(30)} | #{row["savedMoney"].to_s.rjust(11)} | #{row["totalAmount"].to_s.rjust(11)} | #{row["date"]} | #{row["fulfilled"].to_s} |\n"
		end

		return list

	end

end
