class JobActivitiesController < ApplicationController

  def wip_job
    params.permit!
    job_activity = JobActivity.where(id: params[:id]).first
    job_activity.wip_job
    redirect_to "/dashboard"
  end

  def done_job
    params.permit!
    job_activity = JobActivity.where(id: params[:id]).first
    job_activity.done_job
    redirect_to "/dashboard"
  end

  def reject_job
    params.permit!
    job_activity = JobActivity.where(id: params[:id]).first
    job_activity.rejected_job(params[:rej_id])
    redirect_to "/dashboard"
  end
end
