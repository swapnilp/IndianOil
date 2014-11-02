class HomeController < ApplicationController
  def index
    @jobs = Job.all.order("id desc").paginate(:page => params[:page])
  end

end
