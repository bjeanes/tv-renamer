require 'fileutils'

class Renamer
  attr_accessor :path, :syntax, :recursive
  
  def initialize(path=".")
    @recursive = true
    @path = File.expand_path(path)
    @api = Tvdb.new
  end
  
  def start
    process
  end
  
  private
  def process(path=@path)
    if File.directory? path      
      puts "Processing directory: " + path
      puts ""
      Dir.chdir(path) { process_cwd }
    else
      Dir.chdir(File.dirname(path)) do
        process_file(File.basename(path))
      end
    end
  end
  
  def process_file(file)
    series, season, number = *TVParser.parse(file)
    
    episode = get_episode(series, season, number)
    
    unless episode.nil? || episode.season_number == 0
      new_name = "#{series} - #{episode.season_number.to_s.rjust(2,'0')}x#{episode.number.to_s.rjust(2,'0')}"
      new_name += " - #{episode.name}" unless episode.name.nil? or episode.name.empty?
      new_name = new_name.strip + "." + file.split('.').last
      
      unless file == new_name
        puts "#{file} -> #{new_name}"
        FileUtils.mv file, new_name
      end
    end
  end
  
  def process_cwd
    Dir.entries('.').each do |entry|
      unless entry =~ /^\./
        if recursive && File.directory?(entry)
          process(File.expand_path(File.join(Dir.pwd, entry)))
        else
          process_file(entry) if VALID_VIDEO_TYPES.include? entry.split('.').last
        end
      end
    end
  end
  
  def get_episode(series, season, number)
    if series.is_a? Fixnum
      @api.get_episode(series, season, number)
    else
      if series = get_series(series)
        series.episode(season, number)
      else
        nil
      end
    end
  end
  
  def get_series(name)
    if not @series or @series[name].nil?    
      series = @api.search(name + " ") # space at end fixes weird TvDB issue
      @series ||= {}
      @series[name] = series
    end
    
    @series[name]
  end
end