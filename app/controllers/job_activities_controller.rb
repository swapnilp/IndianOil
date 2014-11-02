class JobActivitiesController < ApplicationController

  def wip_job
    job_activity = JobActivity.where(paramsp[:id]).first
    job_activity.wip_job
  end

  def done_job
    job_activity = JobActivity.where(paramsp[:id]).first
    job_activity.done_job
  end

  def reject_job
    job_activity = JobActivity.where(paramsp[:id]).first
    job_activity.rejected_job(params[:rej_id])
  end
end
