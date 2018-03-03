class AddSpacedRepetitionFieldsToCard < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :consecutive_correct_answers, :integer
    add_column :cards, :easiness_factor, :decimal
    add_column :cards, :repetition_interval, :integer
    add_column :cards, :next_due_date, :datetime
  end
end
