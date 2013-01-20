class AddOptionsToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :options, :string
  end
end
