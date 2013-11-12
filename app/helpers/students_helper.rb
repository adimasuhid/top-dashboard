module StudentsHelper
  def select_options(hash)
    hash.map{|k,v| [k,v]}
  end
end
