class Webui::CommentsController < Webui::WebuiController
  before_action :find_obj

  def destroy
    comment = @obj.comments.find params[:id]
    unless comment.check_delete_permissions
      flash[:error] = 'No permissions to delete comment'
      redirect_back(fallback_location: root_path)
      return
    end
    comment.blank_or_destroy

    respond_to do |format|
      format.js { render json: 'ok' }
      format.html do
        flash[:notice] = 'Comment deleted successfully'
      end
    end
    redirect_back(fallback_location: root_path)
  end

  protected

  def find_obj
    if params[:project]
      if params[:package]
        @template = 'package'
        @obj = Package.get_by_project_and_name(params[:project], params[:package])
      else
        @template = 'project'
        @obj = Project.get_by_name(params[:project])
      end
    else
      @template = 'request'
      @obj = BsRequest.find_by_number!(params[:id])
    end
  end
end
