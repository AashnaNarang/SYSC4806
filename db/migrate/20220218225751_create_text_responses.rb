class CreateTextResponses < ActiveRecord::Migration[7.0]
  def change
    create_table :text_responses do |t|
      t.text :response

      t.timestamps
    end
  end
end
