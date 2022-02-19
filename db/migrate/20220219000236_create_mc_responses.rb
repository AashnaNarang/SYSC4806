class CreateMcResponses < ActiveRecord::Migration[7.0]
  def change
    create_table :mc_responses do |t|

      t.timestamps
    end
  end
end
