module StarcraftApi

  class Nios
    attr_accessor :tag, :name, :html, :members

    def initialize

    end

    def clan tag
      @tag = tag
      request = RestClient.get("http://nios.kr/sc2/us/clan/detail/#{tag}", :user_agent => 'Chrome')
      @html = Nokogiri::HTML(request.body)
      @members = []
      @html.css("#ladderData > tbody > tr").each do |player|
        return nil if player.css("td").length == 1
        tag = player.css(".clanTag").inner_html
        race = ""
        league = ""
        player.css(".name > img").each do |data|
          race = data.attr("src")[-5,1]
          league = data.attr("src")[-5,1] if data.attr("src")[-5,1].match(/[0-9]/)
        end
        @members.push(parse_player(player.css('.name > a').attr("href"), league, race, tag))
      end
    end

    def parse_player(url, league, race, tag)
      parts = url.to_s.split("/")
      leagueType = ["grandmaster","master","diamond","platinum","gold","silver","bronze",""]
      raceType = { "p" => "protoss", "t" => "terran", "z" => "zerg", "" => "" }
      profile = {
        :tag => tag,
        :name => parts[-1],
        :realm => parts[-2],
        :id => parts[-3],
        :league => leagueType[league.to_i-1],
        :race => raceType[race]
      }
    end

    def get_profiles
      members = []
      nil if @members.length == 0
      @members.each do |member|
        profile = StarcraftApi::Profile.new
        profile.full_data(member[:name], member[:id], member[:realm])
        members.push(profile)
      end
      @members = members
    end

  end

end
