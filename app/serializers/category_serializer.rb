class CategorySerializer < ActiveModel::Serializer
  attributes :name, :id, :parent_id

  embed :ids
  has_many :children, include: true, root: 'categories', key: 'category_ids'

end