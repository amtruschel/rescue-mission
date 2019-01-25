class RemoveBestAnswerColumnFromResponses < ActiveRecord::Migration[5.2]
  def change
    remove_column :responses, :best_answer_votes, :integer
  end
end
