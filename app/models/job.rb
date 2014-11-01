class Job < ActiveRecord::Base
  has_many :job_activities

  after_create :create_job_activity
  
  
  def create_job_activity
    Activity.all.each do |activity|
      new_job_activity = self.job_activities.build({activity_id: activity.id,  duration: activity.duration, user_id: activity.user_id, start_date: self.job_activities.last.try(:end_date) || self.start_date, end_date: (self.job_activities.last.try(:end_date) || self.start_date) + activity.duration.days, user_name: activity.user_name, is_background: activity.is_background, activity_type: activity.activity_type, capicity: activity.capacity })

      new_job_activity.previous_activity = activity.pre_activity.job_activities.where(job_id: self.id).first.try(:id) if activity.pre_activity.present?
      new_job_activity.save
    end
  end
    
  

  
end
