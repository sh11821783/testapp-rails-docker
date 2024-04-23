class ApplicationController < ActionController::Base
  # Devise コントローラーの場合にのみ実行するメソッドを設定
  # Devise コントローラーのアクションが呼び出される前に、configure_permitted_parameters メソッドを呼び出します。
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ユーザーがサインインした後のリダイレクト先を指定するメソッド
  # サインイン後にユーザーをリダイレクトする先のパスを指定します。ここではユーザーの詳細ページにリダイレクトされます。
  def after_sign_in_path_for(resource)
    user_path
  end

  # ユーザーがサインアップした後のリダイレクト先を指定するメソッド
  # サインアップ後にユーザーをリダイレクトする先のパスを指定します。ここではユーザーの詳細ページにリダイレクトされます。
  def after_sign_up_path_for(resource)
    user_path
  end
  
  # ユーザーがサインアウトした後のリダイレクト先を指定するメソッド
  # サインアウト後にユーザーをリダイレクトする先のパスを指定します。ここではログインページにリダイレクトされます。
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end 

  protected

  # Devise の許可されたパラメーターを構成するメソッド
  # ユーザー登録時に許可されるパラメーターを指定します。
  # デフォルトでは、email と password のみが許可されていますが、ここでは name も追加されています。
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
