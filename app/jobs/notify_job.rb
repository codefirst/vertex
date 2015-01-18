class NotifyJob
   def perform(schedule_id)
     ActiveRecord::Base.connection_pool.with_connection do
       schedule_id = schedule_id.first if schedule_id.is_a? Array
       schedule = Schedule.find(schedule_id)
       schedule.user.notify!
     end
   end
 end
