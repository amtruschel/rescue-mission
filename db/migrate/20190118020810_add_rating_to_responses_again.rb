class AddRatingToResponsesAgain < ActiveRecord::Migration[5.2]
  def change
    add_column :responses, :ranking, :integer
  end
end
