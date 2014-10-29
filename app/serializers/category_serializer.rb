class CategorySerializer < ActiveModel::Serializer
  attributes :name, :id, :parent_id, :prev_id, :next_id, :parent

  embed :ids
  has_many :children, include: true, root: 'categories', key: 'category_ids'

  def prev_id
    nil
  end

  def next_id
    nil
  end

  def parent
    nil
  end

end