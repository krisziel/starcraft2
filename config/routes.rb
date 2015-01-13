Rails.application.routes.draw do
  root 'clans#index'
  post 'clans/search/' => 'clans#search', :format => 'json'
  post 'clans/create' => 'clans#create', :format => 'json'
  post 'players/create' => 'players#create', :format => 'json'
  get 'clans/:tag' => 'clans#view'
  # get 'clans/:tag.json' => 'clans#data', :format => 'json'
  post 'clans/.json' => 'clans#data', :format => 'json'
  get 'players/:handle/bnet.json' => 'players#bnetdata', :format => 'json'
  get 'players/:handle/sc2ranks.json' => 'players#sc2ranksdata', :format => 'json'
  get 'players/:handle/ggtracker.json' => 'players#ggtrackerdata', :format => 'json'
end
