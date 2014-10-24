module AdminSearchRansack
  def ransack_params(params)
    map_to_ransack(params[:q]).merge!(map_ransack_sort(params[:sort], params[:orderAscending]))
  end

  def map_to_ransack(q)
    query = decode_query(q)
    result = {}
    query.keys.each do |attr|
      if query[attr]["predicat"]
        p = predicate_to_ransack(query[attr]["predicat"])
        result["#{attr}_#{p}"] = query[attr]["value"]
      else
        result["#{attr}_cont"] = query[attr]["value"]
      end
    end
    result
  end

  def ransack_automplete_params(field, q)
    {"#{field.to_s}_cont" => q}
  end

  def map_ransack_sort(field_name, is_sort_asc)
    sort = to_boolean(is_sort_asc) ? 'asc' : 'desc'
    {'s' => "#{field_name} #{sort}"}
  end

  def decode_query(q)
    Rack::Utils.parse_nested_query(q)
  end

  def predicate_to_ransack(p)
    case p
      when '='
        'eq'
      when '>='
        'gt'
      when '<='
        'lt'
      else
        'eq'
    end
  end

  def to_boolean(str)
    str == 'true'
  end
end