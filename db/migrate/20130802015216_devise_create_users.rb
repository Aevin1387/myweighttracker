class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      # Omniauthable
      t.string :provider
      t.string :uid

      # Fitbit oAuth
      t.string :full_name
      t.string :display_name
      t.string :oauth_token
      t.string :oauth_token_secret

      t.timestamps
    end

    add_index :users, :uid,                :unique => true
  end
end
