require 'oauth'
require 'api_translator'
@options = {:daemonize => false, :port => 3010, :syslog => true, :events => true, :test => false, url: 'https://demo.videofurnace.com/apis',
           :address => '127.0.0.1', :oauth => true, :consumer_key => 'xjEgYRE3C09FB-46e6pbRw', consumer_secret: '0BBsYUgHNn0JPsFN70T7MQ'}

ApiTranslator.port = @options[:port] if @options[:port]
ApiTranslator.url = @options[:url] if @options[:url]
ApiTranslator.test = @options[:test]
ApiTranslator.address = @options[:address]
consumer = OAuth::Consumer.new(@options[:consumer_key], @options[:consumer_secret], :site => @options[:url])
ApiTranslator.access_token = OAuth::AccessToken.new consumer
RestClient.add_before_execution_proc do |req, params|
  ApiTranslator.access_token.sign! req
end

require 'haivision'
module Haivision
  API = ApiTranslator.url
end
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
