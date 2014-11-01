class JobActivity < ActiveRecord::Base

  belongs_to :pre_activity, class_name: "JobActivity", foreign_key: :previous_activity
  has_one :next_activity, class_name: "JobActivity", foreign_key: :previous_activity
  belongs_to :job
  belongs_to :activity
  scope :master_activity, lambda{ where(previous_activity: nil) }


  def move_next
    next_act = self.next_activity
    if next_act.present?
      next_next_act = next_act.next_activity
      self_pre_id = self.previous_activity
      next_pre_id = next_act.id
      
      self.update_attributes({previous_activity: next_pre_id})
      next_act.update_attributes({previous_activity: self_pre_id})
      if next_next_act.present?
        next_next_act.update_attributes({previous_activity: self.id})
      end
    end
  end

  def move_previous
    prev_act = self.pre_activity
    if prev_act.present?
      nxt_act = self.next_activity
      
      self_pre_id = self.previous_activity
      pre_pre_id = prev_act.previous_activity

      self.update_attributes({previous_activity: pre_pre_id})
      prev_act.update_attributes({previous_activity: self.id})
      
      if nxt_act.present?
        nxt_act.update_attributes({previous_activity: prev_act.id})
      end
    end
    
  end

  
end
