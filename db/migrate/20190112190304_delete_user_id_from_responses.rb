class DeleteUserIdFromResponses < ActiveRecord::Migration[5.2]
  def change
    remove_column :responses, :user_id, :string
  end
end
