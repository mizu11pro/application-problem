class ApplicationController < ActionController::Base
   before_action :authenticate_user!,except: [:top, :about]
   before_action :configure_permitted_parameters, if: :devise_controller?
   add_flash_types :success, :info, :warning, :danger
  # 自動住所検索機能
  # パラメータの設定を許可する


def after_sign_in_path_for(resource)
    user_path(current_user)
end

def after_sign_up_path_for(resource)
    user_path(current_user)
end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email]) #sign_upに：email登録を追加
  end

end
