class JobsController < ApplicationController
  
  def index
    @jobs = Job.all.order("id desc").paginate(:page => params[:page])
  end
  
  
  def show
    @jobs = Job.select([:id, :name])
    @job = Job.where(id: params[:id]).first
    @master_activity = @job.job_activities.master_activity.first
  end


  def move_activity
    job = Job.where(id: params[:id]).first
    activity = job.job_activities.where(id: params[:job_activity_id]).first
    activity.move_action(params[:act_action])
    master_activity = job.job_activities.master_activity.first
    render json: {success: true, html: render_to_string(:partial => "activity.html.erb", :layout => false, locals: {activity: master_activity, job: job })} 
  end

  def new
    @job = Job.new
  end

  def create
    params.permit!
    job = Job.new(params[:job])
    job.save
    redirect_to jobs_path(job)
  end
  
end
