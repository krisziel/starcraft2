class ClansController < ApplicationController

  def index
  end

  def search
    clans = Clan.where(:tag => params[:tag].upcase)
    p clans
    if clans.length == 0
      @clan = StarcraftApi::Nios.new
      @clan.clan(params[:tag])
    else
      @clan = {
        :tag => clans.first['tag'],
        :name => clans.first['name'],
        :id => clans.first['id']
      }
    end
  end

  def create
    params[:region] = 1
    params[:tag] = params[:tag].upcase
    params[:clan] = {
      :region => params[:region],
      :tag => params[:tag]
    }
    clan = Clan.new(params.require(:clan).permit(:tag,:name,:region))
    if clan.save
      @result = clan
      @clan = StarcraftApi::Nios.new
      @clan.clan(params[:tag])
      @clan.members.each do |member|
        player = StarcraftApi::Ggtracker.new
        player.bnet(member[:name], member[:id], member[:realm])
        Player.create!(
          :bnetid => member[:id],
          :name => member[:name],
          :region => member[:realm],
          :ggtrackerid => player.ggtrackerid,
          :clan_id => clan.id,
          :one => player.league_1v1.to_json,
          :two => player.league_2v2.to_json,
          :three => player.league_3v3.to_json,
          :four => player.league_4v4.to_json,
          :high => player.league_highest.to_json,
          :apm => player.apm,
          :season_games => player.season_games,
          :total_games => player.career_games
        )
      end
    else
      clan = Clan.find_by({:tag => params[:tag].upcase})
      if clan
        @result = {
          :tag => clan.tag,
          :id => clan.id
        }
      else
        @result = {
          :response => "error"
        }
      end
    end
  end

  def data
    clan = Clan.find_by({:tag => params[:tag].upcase})
    @clan = {:here => clan.id}
  end

end
