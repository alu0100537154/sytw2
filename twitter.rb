
require 'twitter'
require 'sinatra'

require './configure'

get '/' do
  @nfriends = []
  @name = ''
  @number = 0
  erb :twitter
end

post '/' do
  @nfriends = []
  client = my_twitter_client() 
  @name = params[:firstname] || ''
  @number = params[:n].to_i
  @number = 1 if @number < 1
  if (client.user? @name) && (@number <= 10)
 ultimos_t = client.friends(@name,{:skip_status => 1, :include_user_entities => false}).take(@number)
    @nfriends =(@nfriends != '') ? ultimos_t.map{|i| [i.name ,i.followers_count]}: ''
    @nfriends.sort_by!{|c,d| d}.reverse!
    
  end
  erb :twitter
end

