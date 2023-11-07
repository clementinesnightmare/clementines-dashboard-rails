class AddPublicProfileToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :public_profile, :boolean


    User.all.each do |user|
      user.public_profile = false
      user.save!
    end
  end
end
