require 'vk-console'
require 'logger'

class AudioSync < VK::Console
  def initialize(app_id, email, password, log_file, debug)
    @email = email
    @password = password
    log_file ||='stdout'

    if log_file.downcase == 'stdout'
      log = Logger.new(STDOUT)
    else
      file = File.open(log_file, File::WRONLY | File::APPEND)
      log = Logger.new(file)      
    end

    super :app_id => app_id, :email => email, :password => password, :logger => log, :debug => false
  end
  
  def sync(dir)
    old_dir = Dir.pwd
    Dir.chdir(dir)
    puts '-' * 100
    audio.get.each do |track|
      print "download #{track['artist']}-#{track['title']} "
      download_track track
      puts '=> complite'
      puts '-' * 100  
    end  

    Dir.chdir(old_dir)
  end

  def download_track(track)
    uri = URI.parse track['url']
    resp = http(:host => uri.host, :port => 80, :ssl => false).get uri.path
    file = friendly_filename "#{track['artist']}_#{track['title']}.mp3"
    File.open( file, 'wb') { |file| file.write(resp.body) }
  end

  def friendly_filename(filename)
    filename.gsub(/[^\w\s_-]+/, '')
            .gsub(/(^|\b\s)\s+($|\s?\b)/, '\\1\\2')
            .gsub(/\s/, '_')
  end


end

require 'yaml'

config = YAML.load_file("./config.yml")
app = AudioSync.new config['app_id'], 
                    config['email'], 
                    config['password'], 
                    config['logfile'], 
                    config['debug']
                    
app.sync config['save_dir']