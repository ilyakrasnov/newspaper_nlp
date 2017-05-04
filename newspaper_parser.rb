require 'nokogiri'

class Paper
  def initialize(file)
    @doc = File.open(file) { |f| Nokogiri::XML(f) }
  end

  def titles
    puts articles.map{|article| article.title}
  end

  def articles
    @articles ||= children
      .select{|c| c['ENTITY_TYPE'] == "Article"}
      .map{|node| Article.new(node)}
  end

  def children
    @children ||= @doc.children.children
  end

end

class Article
  def initialize(node)
    @node = node
  end

  def title
    attributes[1].text
  end

  def attributes
    @attributes ||= @node.children
  end

end

paper = Paper.new("Pg001.xml")
paper.titles
