require 'rubygems'
require 'open-uri'
require 'hpricot'

f = File.open(File.expand_path("../../data/non_twss.txt", __FILE__), "w")

domain = "http://www.fmylife.com"

200.times do |i|
  url = domain + "/intimacy?page=#{i}"
  puts url
  body = open(url).read
  doc = Hpricot(body)
  doc.search('div.post p a.fmllink') do |story|
    f.puts story.to_plain_text
  end
  f.flush
  sleep rand * 3.0
end

f.close
