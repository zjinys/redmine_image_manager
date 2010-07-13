class AddMemoToImages < ActiveRecord::Migration
  def self.up
    add_column :images, :memo, :string
  end

  def self.down
    remove_column :images, :memo
  end
end
