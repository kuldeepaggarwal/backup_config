# encoding: utf-8

# $ backup perform -t roshreview_database_backup
Backup::Model.new(:roshreview_database_backup, 'This takes backup of Roshreview Database') do
  split_into_chunks_of 250

  database MySQL do |db|
    db.name               = 'activerecord_unittest'
    db.username           = 'root'
    db.password           = ''
    db.host               = 'localhost'
    db.port               = 3306
    db.additional_options = ["--quick", "--single-transaction"]
  end
  
  store_with CloudFiles
  compress_with Gzip
  store_with Local
end
