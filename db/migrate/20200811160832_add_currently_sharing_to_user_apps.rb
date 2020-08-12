class AddCurrentlySharingToUserApps < ActiveRecord::Migration[5.2]
  def change
    add_column :user_apps, :currently_sharing, :boolean
  end
end
