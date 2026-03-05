class ChangeDateToDatetimeInExpenses < ActiveRecord::Migration[7.2]
  def change
    change_column :expenses, :date, :datetime
  end
end
