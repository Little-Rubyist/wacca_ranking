module HomeHelper
  def info_files
    files = Dir.glob('app/views/home/information/*.html.haml').sort_by{ |fn| fn}.reverse!
    files.map{|f| f.slice(/\d{4}_\d{2}_\d{2}/)}
  end
end
