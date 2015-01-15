class AddLeaguesToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :one, :json
    add_column :players, :two, :json
    add_column :players, :three, :json
    add_column :players, :four, :json
    add_column :players, :high, :json
    add_column :players, :apm, :integer
    add_column :players, :season_games, :integer
    add_column :players, :total_games, :integer
  end
end
