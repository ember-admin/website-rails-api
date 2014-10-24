class AddMapAttrsToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :lat, :float
    add_column :companies, :long, :float
    add_column :companies, :zoom, :integer, default: 1
  end
end
