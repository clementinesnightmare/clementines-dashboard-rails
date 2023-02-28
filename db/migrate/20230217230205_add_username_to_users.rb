class AddUsernameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :username, :string

    User.all.each do |user|
      user.username = user.eth_address
      user.save!
    end

    add_index :users, :username, unique: true
  end
end
