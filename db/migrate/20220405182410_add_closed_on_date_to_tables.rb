class AddClosedOnDateToTables < ActiveRecord::Migration[7.0]
  def change
    add_column :surveys, :closedOnDate, :datetime
  end
end
