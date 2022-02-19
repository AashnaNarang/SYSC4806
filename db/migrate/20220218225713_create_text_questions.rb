class CreateTextQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :text_questions do |t|
      t.text :question

      t.timestamps
    end
  end
end
