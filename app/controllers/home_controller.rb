class HomeController < ApplicationController

  def index
    if current_user.id != 1
      redirect_to "/dashboard"
    end
    @jobs = Job.all.order("id desc").paginate(:page => params[:page])
  end


  def dashboard
    @job_activities = JobActivity.where(user_id: 4, status: ['PENDING', 'WIP']).order("id desc").paginate(:page => params[:page])
    render layout: 'application1'
    
  end

end
