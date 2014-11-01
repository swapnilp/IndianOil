class JobsController < ApplicationController
  
  def index
    @jobs = Job.all.order("id desc").paginate(:page => params[:page])
  end
  

  def show
    @jobs = Job.select([:id, :name])
    @job = Job.where(id: params[:id]).first
    @master_activity = @job.job_activities.master_activity.first
  end
end
