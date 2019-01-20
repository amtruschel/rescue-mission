class AddGithubColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :provider, :string
    add_column :users, :oauth_token, :string
    add_column :users, :username, :string
    add_column :users, :avatar_url, :string
  end
end
