class CreateSurveyResponders < ActiveRecord::Migration[7.0]
  def change
    create_table :survey_responders do |t|
      t.time :respondedAt

      t.timestamps
    end
  end
end
