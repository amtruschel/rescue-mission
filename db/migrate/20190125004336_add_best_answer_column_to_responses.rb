class AddBestAnswerColumnToResponses < ActiveRecord::Migration[5.2]
  def change
    add_column :responses, :best_answer, :boolean
  end
end
