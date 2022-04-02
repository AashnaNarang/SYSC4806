class CreateMcOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :mc_options do |t|
      t.text :option

      t.timestamps
    end
  end
end
