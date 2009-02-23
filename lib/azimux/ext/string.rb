String.class_eval do
  raise "to_directory_tree already defined" if methods.index('to_directory_tree')
  def to_directory_tree
    dirs = to_directory_tree_parts
    File.join(*dirs)
  end

  def to_directory_tree_partial
    dirs = to_directory_tree_parts[0..-2]
    File.join(*dirs)
  end
  
  def to_directory_tree_parts
    val = String.new self
    val.gsub!(/\s/, '')
    raise "not a numeric string" unless val =~ /^\d+$/
    
    dirs = []
    
    val.reverse!
    
    while val =~ /\d{1,2}/
      dirs << $&
      val = $'
    end
    
    dirs.reverse!
    dirs.map!(&:reverse)
  end
end