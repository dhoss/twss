require File.expand_path('../lib/twss', File.dirname(__FILE__))
require File.expand_path('../lib/twss/tweet_collector', File.dirname(__FILE__))

TWSS::TweetCollector.new(':)', File.join(File.dirname(__FILE__), '../data/non_twss.txt')).run
