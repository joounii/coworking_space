class SeatsController < InheritedResources::Base
  before_action :is_admin

  private

    def seat_params
      params.require(:seat).permit(:title)
    end

  def is_admin
      flash[:alert] = "You are not authorized to access seats."
      redirect_to root_path
  end

end
