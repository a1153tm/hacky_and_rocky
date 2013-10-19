class RemoveSalesDateFromBooks < ActiveRecord::Migration
  def change
    remove_column :books, :sales_date, :date
  end
end
