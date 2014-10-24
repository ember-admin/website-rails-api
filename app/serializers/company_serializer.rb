class CompanySerializer < ActiveModel::Serializer
  attributes :id, :title, :lat, :long, :zoom, :updated_at, :created_at

  embed :ids, include: true
  has_one :logo
  has_many :products, include: false
end