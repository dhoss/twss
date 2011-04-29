require File.expand_path('../lib/twss', File.dirname(__FILE__))
require File.expand_path('../lib/twss/tweet_collector', File.dirname(__FILE__))

TWSS::TweetCollector.new('#twss', File.join(File.dirname(__FILE__), '../data/twss.txt')).run
