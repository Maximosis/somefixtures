$: << File.join(File.dirname(__FILE__), "/../lib")

require 'spec'
require 'somefixtures'
require 'fakeweb'

module Helper
  include FakeWeb
  FakeWeb.allow_net_connect = false

  def fixtures filename
    return '' if filename == ''
    path = File.expand_path(File.dirname(__FILE__) + '/fixtures/' + filename )
    File.read path
  end

  def get_url url
    url =~ /^http/ ? url : "http://jbw:pass@github.com/api/v2/json#{url}"
  end

  def stub_get(*args);  stub_request(:get,  *args) end
  def stub_post(*args); stub_request(:post, *args) end  

  def stub_request(option, url, filename, status = nil)
    options = { :body => "" }
    options.merge!( { :body => fixtures(filename) } ) if filename
    options.merge!( { :body => status.last } ) if status
    options.merge!( { :status => status } ) if status
    FakeWeb.register_uri(option, get_url(url), options)
  end
  
  def self.valid
    {
      :login    => "jbw",
      :token    => "pass",
      :save_to  => "/Users/jbw/Desktop/",
      :format   => "json",
      :base_uri => "http://github.com/api/v2/json"
    }
  end

  def self.invalid
    {
      :login    => "false",
      :token    => "false",
      :save_to  => "/Users/jbw/Desktop/",
      :format   => "json",
      :base_uri => "http://github.com/api/v2/json"
    }
  end
end
