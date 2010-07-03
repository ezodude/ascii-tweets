# encoding: utf-8

require "rubygems"
require "rest_client"
require "json"
require "nokogiri"

TWEET_TEXT_FONTS = %w(rozzo big fuzzy bulbhead speed nancyj-fancy gothic cosmike straight smisome1 stampatello  tinker-toy kban lcd wavy)

tweets = []

while true
  res = '[]'
  begin
    res = RestClient.get 'http://api.twitter.com/search.json?q=podcast%20suggestions'
  rescue Exception => e
    p [:exception, e]
    sleep 15
  end 
  
  parsed = JSON.parse(res)
  next if parsed.empty?
  
  tweets = parsed['results'] - tweets
  tweets.each do |tweet|
    user = tweet['from_user']
    puts `figlet -f doom "@#{user}:"`
    sleep 1.5
    
    tweet_content = tweet['text']
    tweet_content.split(" ").each { |word| 
      print `figlet -f #{TWEET_TEXT_FONTS[rand(TWEET_TEXT_FONTS.size - 1)]} "#{word}"` 
      sleep 1
    }
    puts "\n\n################################################\n\n  "
    sleep 10
  end
  sleep 15
end
