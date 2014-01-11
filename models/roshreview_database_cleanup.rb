# encoding: utf-8
require File.join(Dir.pwd, '/lib/cycler_override')

SECONDS_IN_DAY = 24 * 60 * 60
NO_OF_DAYS_TO_SKIP = 0

model_instance = Backup::Model.new(:roshreview_database_cleanup, '')

class << model_instance
  def perform!
    Backup::Model.new(:roshreview_database_backup, '') do
      store_with CloudFiles do |cf|
        min_day_passed = (Time.now.utc - NO_OF_DAYS_TO_SKIP * SECONDS_IN_DAY)
        start = 0
        cf.keep = lambda do |pkg|
          time = (pkg.time.class == String) ? Time.strptime(pkg.time, '%Y.%m.%d.%H.%M.%S') : pkg.time
          will_be_deleted = time < min_day_passed && time.hour > start
          pkg.no_cycle = !will_be_deleted
          will_be_deleted
        end
      end
    end.storages.first.send :cycle!
  end
end