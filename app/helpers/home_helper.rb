module HomeHelper
  def info_files
    files = Dir.glob('app/views/home/information/*.ja.html.haml').sort_by{ |fn| fn}.reverse!
    files.map{|f| f.slice(/\d{4}_\d{2}_\d{2}_?\d*/)}
  end

  def paypay_url
    'https://qr.paypay.ne.jp/p2p01_JeBXL4V5EegOYY7H'
  end
end
