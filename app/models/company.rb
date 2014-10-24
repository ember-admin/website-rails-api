class Company < ActiveRecord::Base
  has_many :products
  has_one :logo, -> { where is_main: true }, :as => :assetable, dependent: :destroy
end
