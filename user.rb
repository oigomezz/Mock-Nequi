
class User
  attr_accessor :name, :password, :email

  def initialize( name, password, email)
  	@name = name
  	@password = password
  	@email = email
    @db_connection = DbConnection.new()
  end


end
