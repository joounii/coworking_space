class SeatsController < InheritedResources::Base

  private

    def seat_params
      params.require(:seat).permit(:title)
    end

end
