require_relative 'connection.rb'
require_relative "menu.rb"
require 'digest'
class Login

  attr_accessor :email, :password, :db_connection

  def initialize(user)
    @db_connection = DbConnection.new()
    @user_name = user.name
    @email = user.email
    @password =  Digest::SHA1.hexdigest user.password

  end

  def id_current_user
    result = @db_connection.client.query("select id from users where mail=\"#{email}\" and password= \'#{password}\' limit 1;", :symbolize_keys => true)
    id_user=nil
    result.each do |row|
      id_user =row[:id]
    end
    return id_user
  end


  def current_user_is_logged(user)
    result = @db_connection.client.query("select id from users where mail=\"#{email}\" and password= \'#{password}\' limit 1;", :symbolize_keys => true)
    id_user=nil
    result.each do |row|
      id_user =row[:id]
    end
    if id_user== nil
      puts "Correo o contraseña incorrecta","Pulse enter para volver"
      option = gets.chomp
    else
      puts "que es esto #{user.class}"
      mnu = Menu.new(user)
      mnu.main_menu(user)
    end
  end

end
