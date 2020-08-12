class AddAdminToSystem < ActiveRecord::Migration[5.2]
  def up
    admin = User.new
    admin.username = 'admin'
    admin.password = "secret"
    admin.password_confirmation = "secret"
    admin.role = "admin"
    admin.save
  end
  def down
    admin = User.find_by_username "username"
    User.delete admin
  end
end