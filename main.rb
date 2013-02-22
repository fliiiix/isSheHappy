require 'sinatra'
require 'erb'
require 'rss'
require 'open-uri'

include ERB::Util

get '/' do
	#if someone know why i need to use this randomshit EXPLAIN me i don't get it O.o
	happyFeed = getFeed("http://thecolorsofart.tumblr.com/rss?" + Random.rand(20).to_s)
	sadFeed = getFeed("http://onlyonecrazylife.tumblr.com/rss?" + Random.rand(20).to_s)

	happyRSS = RSS::Parser.parse(happyFeed, false)
	sadRSS = RSS::Parser.parse(sadFeed, false)

	if happyRSS.items.first.date > sadRSS.items.first.date
		@answer = "Yes"
		@img = "happy.png"
	else
		@answer = "No"
		@img = "sad.png"
	end
	
	erb :index
end

def getFeed(url)
	rss_content = ""
	open(url) do |f|
		rss_content = f.read
	end
	return rss_content
end
