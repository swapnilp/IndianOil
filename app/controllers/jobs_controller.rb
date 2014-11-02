class JobsController < ApplicationController
  
  def index
    @jobs = Job.all.order("id desc").paginate(:page => params[:page])
  end
  
  
  def show
    @jobs = Job.select([:id, :name])
    @job = Job.where(id: params[:id]).first
    @master_activity = @job.job_activities.master_activity
  end


  def move_activity
    job = Job.where(id: params[:id]).first
    activity = job.job_activities.where(id: params[:job_activity_id]).first
    activity.move_action(params[:act_action])
    master_activities = job.job_activities.master_activity
    html = ""
    master_activities.each do  |master_activity|
      html << render_to_string(:partial => "activity.html.erb", :layout => false, locals: {activity: master_activity, job: job })
    end
    render json: {success: true, html: html} 
  end

  def new
    @job = Job.new
  end

  def create
    params.permit!
    job = Job.new(params[:job])
    job.save
    job.start_job
    redirect_to jobs_path(job)
  end
  
end
