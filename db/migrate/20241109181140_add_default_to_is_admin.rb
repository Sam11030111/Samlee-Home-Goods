class AddDefaultToIsAdmin < ActiveRecord::Migration[7.2]
  def change
    change_column_default :users, :isAdmin, false
  end
end
