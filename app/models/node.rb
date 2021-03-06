class Node < ActiveRecord::Base
  extend FriendlyId
  include Markdown
  friendly_id :name, use: :slugged

  attr_accessible :name, :content, :category, :category_id, :links_attributes, :tags, :hotness

  has_and_belongs_to_many :nodes,
                          :class_name => "Node",
                          :join_table => "nodes_nodes",
                          :foreign_key => "from_id",
                          :association_foreign_key => "to_id"

  has_and_belongs_to_many :parent_nodes,
                          :class_name => "Node",
                          :join_table => "nodes_nodes",
                          :foreign_key => "to_id",
                          :association_foreign_key => "from_id"

  belongs_to :category
  has_many :links

  accepts_nested_attributes_for :links

  def summary
    html = markdown(self.content)
    document = Nokogiri::HTML.parse html
    document.text.truncate(200)
  end
end
