class ApplicationController < ActionController::Base
  before_action :set_search
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_search
    @q = Post.ransack(params[:q])
    @search_results = @q.result(distinct: true)
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :user_name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:user_name, :website,
                                      :self_introduction, :sex, :phone_number])
    end
end
