class AddLoggedinToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :loggedin, :boolean
  end
end
