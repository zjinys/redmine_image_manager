class Image < ActiveRecord::Base
  belongs_to :project,:class_name => 'Project', :foreign_key => 'project_id'
  belongs_to :author, :class_name => 'User', :foreign_key => 'author_id'

  acts_as_attachable
end
