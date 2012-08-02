class Node < ActiveRecord::Base
  attr_accessible :content
  has_and_belongs_to_many :nodes,
                          :class_name => "Node",
                          :join_table => "nodes_nodes",
                          :foreign_key => "from_id",
                          :association_foreign_key => "to_id"

end
