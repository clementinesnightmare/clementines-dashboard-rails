class AddLunchMoneyToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :lunch_money, :bigint, default: 0
    add_index :users, :lunch_money
  end

  def down
    remove_index :users, :lunch_money
    remove_column :users, :lunch_money
  end
end
