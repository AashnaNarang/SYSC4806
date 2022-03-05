class ChangeWentLiveAt < ActiveRecord::Migration[7.0]
  def change
      change_column :surveys, :wentLiveAt, :datetime
  end
end
