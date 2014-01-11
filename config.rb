# encoding: utf-8

Backup::Storage::CloudFiles.defaults do |cloudFile|
  cloudFile.api_key      = ''
  cloudFile.username     = ''
  cloudFile.container    = 'BackupTestContainer'
  cloudFile.path         = '~/backups'
  cloudFile.days_to_keep = 30
  cloudFile.keep         = 120
end

Backup::Storage::Local.defaults do |local|
  local.path       = '~/backups/'
  local.keep       = 28
end

Backup::Compressor::Gzip.defaults do |compressor|
  compressor.level = 6
end

# backup perform -t roshreview_ckeditor_assets_backup,roshreview_database_backup
Dir[File.join(File.dirname(Config.config_file), 'models', '*.rb')].each do |model|
  instance_eval(File.read(model))
end
