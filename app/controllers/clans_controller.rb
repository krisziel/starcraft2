class ClansController < ApplicationController

  def index
    @profile = StarcraftApi::Profile.new
    @profile.full_data("lIBARCODEIl",6117903,1)
    @clan = StarcraftApi::Nios.new
    @clan.clan('xFTAx')
  end

end
