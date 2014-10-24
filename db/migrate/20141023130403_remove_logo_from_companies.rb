class RemoveLogoFromCompanies < ActiveRecord::Migration
  def change
    remove_column :companies, :logo
  end
end
