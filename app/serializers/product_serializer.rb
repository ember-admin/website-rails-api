class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :title_en, :title_de, :title_fr, :title_ru, :price, :updated_at, :created_at, :is_active
  has_one :company, include: true
  has_one :user, include: true
  has_one :product_image, include: true
  has_many :product_images, include: true
  embed :ids, include: false
end