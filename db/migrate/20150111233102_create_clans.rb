class CreateClans < ActiveRecord::Migration
  def change
    create_table :clans do |t|
      t.string :tag
      t.string :name
      t.string :region

      t.timestamps
    end
  end
end
