class CreateBands < ActiveRecord::Migration
  def self.up
    create_table :bands do |t|
      t.string :name,        :default => ""
      t.string :genre,       :default => ""
      t.text   :description, :default => ""
      
      t.timestamps
    end
  end

  def self.down
    drop_table :bands
  end
end
