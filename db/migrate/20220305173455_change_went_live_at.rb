class ChangeWentLiveAt < ActiveRecord::Migration[7.0]
  def change
      remove_column :surveys, :wentLiveAt
      add_column :surveys, :wentLiveAt, :datetime
  end
end
