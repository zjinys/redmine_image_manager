class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.column :img_type, :string
      t.column :spec, :string
      t.column :file_name, :string
      t.column :svn_repo, :string
      t.column :svn_path, :string
      t.column :name, :string
      t.column :finish_time, :datetime
      t.column :project_id, :integer
      t.column :create_by, :integer
    end
  end

  def self.down
    drop_table :images
  end
end
