# encoding: utf-8

# $ backup perform -t roshreview_ckeditor_assets_backup
Backup::Model.new(:roshreview_ckeditor_assets_backup, 'This takes backup of Roshreview Assets') do
  split_into_chunks_of 250

  archive :roshreview_archive do |archive|
    archive.add '/var/www/apps/roshreview/shared/ckeditor_assets/'
  end

  store_with CloudFiles
  compress_with Gzip
  store_with Local
end
