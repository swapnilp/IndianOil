class HomeController < ApplicationController

  def index
    
    @jobs = Job.all.order("id desc").paginate(:page => params[:page])
  end


  def dashboard
    @job_activities = JobActivity.where(user_id: 2, status: ['PENDING', 'WIP']).order("id desc").paginate(:page => params[:page])
    
    render layout: 'application1'
    
  end

end
