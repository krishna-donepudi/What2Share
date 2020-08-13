class AddStockUsersToSystem < ActiveRecord::Migration[5.2]
  def up
    bobama = User.new
    bobama.username = 'bobama'
    bobama.password = "secret"
    bobama.password_confirmation = "secret"
    bobama.role = "user"
    bobama.save
    mobama = User.new
    mobama.username = 'mobama'
    mobama.password = "secret"
    mobama.password_confirmation = "secret"
    mobama.role = "user"
    mobama.save
    jayz = User.new
    jayz.username = 'jayz'
    jayz.password = "secret"
    jayz.password_confirmation = "secret"
    jayz.role = "user"
    jayz.save
    beyonce = User.new
    beyonce.username = 'beyonce'
    beyonce.password = "secret"
    beyonce.password_confirmation = "secret"
    beyonce.role = "user"
    beyonce.save
  end
  def down
    bobama = User.find_by_username "username"
    User.delete bobama
    mobama = User.find_by_username "username"
    User.delete bobama
    jayz = User.find_by_username "username"
    User.delete bobama
    beyonce = User.find_by_username "username"
    User.delete bobama
  end
end
