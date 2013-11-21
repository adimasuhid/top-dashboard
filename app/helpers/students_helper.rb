module StudentsHelper
  def select_options_hash(hash)
    hash.map{|k,v| [k,v]}
  end

  def select_options(active_relation, column)
    active_relation.map{|a| [a.send(column), a.id] }
  end
end
