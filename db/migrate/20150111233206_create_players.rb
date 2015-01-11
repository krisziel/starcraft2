class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.integer :bnetid
      t.integer :ggtrackerid
      t.integer :region
      t.integer :clan_id

      t.timestamps
    end
  end
end
