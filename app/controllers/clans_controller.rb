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
    clan = Clan.new(params.require(:clan).permit(:tag,:name,:region))
    if clan.save
      @result = clan
    else
      @result = {
        :response => "error"
      }
    end
  end

  def data
    @clan = {:here => "true"}
  end

end
