require 'rubygems'
require 'bundler/setup'
require 'sinatra/base'
require 'data_mapper'
require 'models'
require 'routes'
require 'helpers'
require 'haml'
require 'sass'
require 'cgi'
require 'pp'

class LightControl < Sinatra::Base

  configure :production do
    enable :sessions
    pp "Loading Production Environment..."
    DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite3://' + Dir.pwd + '/lightcontrol.db') 
    DataMapper.finalize
    DataMapper.auto_upgrade!
  end

  configure :test do
    enable :sessions
    pp "Loading Test Environment..."
    DataMapper.setup(:default, 'sqlite3://' + Dir.pwd + '/lightcontrol_test.db') 
    DataMapper.finalize
    DataMapper.auto_upgrade!
  end

  configure :development do
    enable :sessions
    pp "Loading Development Environment..."
    DataMapper.setup(:default, 'sqlite3://' + Dir.pwd + '/lightcontrol.db') 
    DataMapper.finalize
    DataMapper.auto_upgrade!
  end

  configure do
    enable :static, :session
    set :root, File.dirname(__FILE__)
    set :haml, { :format => :html5 }
  end

  before do
    # Before stuff!
  end

  include Routes

  include Helpers

  pp "Woohoo! LightControl is starting!!!"
end
