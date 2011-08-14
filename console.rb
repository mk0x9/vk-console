#!/usr/bin/env ruby

require 'rubygems'
require 'vk-ruby'
require 'uri'

class Console < VK::Standalone
  
  def initialize(p={})
    @logger = p[:logger]    
    @debug  = p[:debug]  ||= false
    @scope  = p[:scope]  ||= 'notify,friends,photos,audio,video,docs,notes,pages,offers,questions,wall,messages,ads'
    
    raise 'undefined application id' unless @app_id   = p[:app_id]
    raise 'undefined email'          unless @email    = p[:email] 
    raise 'indefined password'       unless @password = p[:password]

    super :app_id => @app_id, :scope => @scope
    raise "unauthorize" unless authorize 
  end

  private

  def authorize
    # user authorization
    form = {'from_host' => 'vkontakte.ru','q' => '1', 'email' => @email, 'pass' => @password, 'act' => 'login', 'al_frame'=> 1}
    resp = http(:host => 'login.vk.com').post '/', (form.map{|k,v| "#{k}=#{v}"}).join('&')
    u = URI.parse resp.response['Location']
    resp = http( :host => 'vkontakte.ru', :port => 80, :ssl => false ).get resp.response['Location'], { 'Cookie' =>  resp.response['set-cookie'] }
    header = { 'Cookie' =>  resp.response['set-cookie'] }
    
    # application authorization
    p = {:client_id => @app_id, :scope => @scope, :display => :page, :redirect_uri => 'http://api.vkontakte.ru/blank.html', :response_type => :token}
    resp = http( :ssl => false , :port => 80).get "/oauth/authorize?" + (p.map{|k,v| "#{k}=#{v}" }).join('&'), header
    params = ''
    resp.body.gsub(/function approve\(\)\s?\{\s*location\.href = \"https\:\/\/api.vk.com\/oauth\/grant_access\?(.+?)\"\;\s*\}/m){ params = $1 }
    resp = http.get '/oauth/grant_access?' + params, header
    location = resp['Location']
    @access_token = location.split('access_token=')[1].split('&')[0]
    @expires_in = location.split('expires_in=')[1].split('&')[0]
    @user_id = location.split('user_id=')[1]
    @access_token && @expires_in && @user_id
  end

end