require 'redmine'

Redmine::Plugin.register :redmine_image_manager do
  name 'Redmine Image Manager plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  permission :images,{:images=>[:index,:new,:show]},:public=>true
  menu :project_menu,:images,{:controller=>'images',:action=>'index'},:caption=>'Images',:param => :project_id
  
end
