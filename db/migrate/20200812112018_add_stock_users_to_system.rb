class AddStockUsersToSystem < ActiveRecord::Migration[5.2]
  def up
    bobama = User.new
    bobama.username = 'bobama'
    bobama.password = "secret"
    bobama.password_confirmation = "secret"
    bobama.role = "non-admin"
    bobama.save
    netflix = App.new
    netflix.name = 'netflix'
    netflix.save
    bobama.apps << netflix
    mobama = User.new
    mobama.username = 'mobama'
    mobama.password = "secret"
    mobama.password_confirmation = "secret"
    mobama.role = "non-admin"
    mobama.save
    jayz = User.new
    jayz.username = 'jayz'
    jayz.password = "secret"
    jayz.password_confirmation = "secret"
    jayz.role = "non-admin"
    jayz.save
    beyonce = User.new
    beyonce.username = 'beyonce'
    beyonce.password = "secret"
    beyonce.password_confirmation = "secret"
    beyonce.role = "non-admin"
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
