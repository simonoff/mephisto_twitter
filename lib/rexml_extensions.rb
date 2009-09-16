class REXML::Element
  def to_hash(default_hash = {})
    convert_node_to_hash(self, default_hash)
  end
  
  protected
    def convert_node_to_hash(node, hash)
      node.elements.each do |elm|
        hash[elm.name] = if elm.elements.empty? then 
            elm.text.to_s.gsub(/(^|[\n ])([\w]+?:\/\/[\w]+[^ \"\n\r\t<]*)/mi,
                               '\1<a href="\2">\2</a>').gsub(
                               /(\@(\w+))/,
                               "<a href=\"http://twitter.com/\\2\">\\1</a>") 
          else
            convert_node_to_hash(elm, hash)
          end
      end
      return hash
    end
end
