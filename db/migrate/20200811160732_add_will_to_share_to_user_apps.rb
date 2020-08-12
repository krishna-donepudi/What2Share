class AddWillToShareToUserApps < ActiveRecord::Migration[5.2]
  def change
    add_column :user_apps, :will_to_share, :string
  end
end
