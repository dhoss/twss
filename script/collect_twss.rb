require 'rubygems'
require 'open-uri'
require 'hpricot'

# Grab the first 2000 stories from twssstories.com (10 per page)

f = File.open(File.expand_path("../../data/twss.txt", __FILE__), "w")

domain = "http://twssstories.com"
200.times do |i|
  url = domain + "/node?page=#{i}"
  puts url
  doc = Hpricot(open(url).read)
  doc.search('div.content p') do |story|
    # now pull out the good stuff...
    if story.to_plain_text =~ /\"(.*)?\"/
      f.puts $1
    end
  end
  f.flush
  sleep rand * 3.0
end

f.close
