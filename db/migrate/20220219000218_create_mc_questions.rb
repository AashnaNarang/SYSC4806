class CreateMcQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :mc_questions do |t|
      t.text :question

      t.timestamps
    end
  end
end
