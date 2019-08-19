
class User
  attr_accessor :name, :email, :password
  def initialize( name, email, password)
  	@name = name
  	@email = email
    @password = password
  end
end
