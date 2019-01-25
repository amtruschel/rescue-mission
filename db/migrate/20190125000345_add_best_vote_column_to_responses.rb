class AddBestVoteColumnToResponses < ActiveRecord::Migration[5.2]
  def change
    add_column :responses,:best_answer_votes,:integer
  end
end
