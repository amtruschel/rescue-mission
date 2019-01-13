class UpdateResponsesUserAndQuestionIdsNotNullable < ActiveRecord::Migration[5.2]
  def change
    change_column :responses, :user_id, :string, null: false
    change_column :responses, :question_id, :integer, null: false
  end
end
