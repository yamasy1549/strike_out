class AddAdultColumnToResults < ActiveRecord::Migration
  def change
    add_column :results, :adult, :boolean, default: true, null: false
  end
end
