class Schedule < ActiveRecord::Base
  include ScheduleChronoCross
  belongs_to :user
end
