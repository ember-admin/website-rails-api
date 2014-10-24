class User < ActiveRecord::Base
  has_many :products
  has_one :avatar, -> { where is_main: true }, :as => :assetable, dependent: :destroy
end
