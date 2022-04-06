class CreateSurveys < ActiveRecord::Migration[7.0]
  def change
    create_table :surveys do |t|
      t.text :title
      t.boolean :isLive
      t.time :wentLiveAt

      t.timestamps
    end
  end
end
