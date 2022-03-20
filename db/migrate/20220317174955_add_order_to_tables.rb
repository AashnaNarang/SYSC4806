class AddOrderToTables < ActiveRecord::Migration[7.0]
  def change
    add_column :mc_questions, :order, :integer
    add_column :text_questions, :order, :integer
  end
end
