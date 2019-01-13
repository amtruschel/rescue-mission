class UpdateQuestionsUserId < ActiveRecord::Migration[5.2]
  def change
    change_column :questions, :user_id, :integer, null: false
  end
end
