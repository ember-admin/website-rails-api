class Product < ActiveRecord::Base
  translates :title
  belongs_to :company
  belongs_to :user
  has_one :product_image, -> { where is_main: true }, :as => :assetable, dependent: :destroy
  has_many :product_images, -> { where is_main: false }, :as => :assetable, dependent: :destroy
end
