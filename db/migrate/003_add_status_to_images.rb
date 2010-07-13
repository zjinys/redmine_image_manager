class AddStatusToImages < ActiveRecord::Migration
  def self.up
    add_column :images, :status, :integer, :default => 1
  end

  def self.down
    remove_column :images, :status
  end
end
