# この行はUsersControllerというクラスを定義しています。
# < シンボルはUsersControllerが他のクラス、ApplicationControllerを継承していることを意味します。
# 継承により、UsersControllerはApplicationControllerのすべてのメソッドやプロパティを使用できます。
class UsersController < ApplicationController
  def show
    # この部分はUsersControllerクラス内にあるshowという名前のメソッドです。
    # Ruby on Railsでは、showメソッドは通常、単一のリソースを表示します。しばしばユーザープロフィールを表示するために使用されます。
    # このメソッドにはコードが含まれていないため、デフォルトでshow.html.erbというビューをレンダリングします。
    # show.html.erbファイル内で、特定のユーザーの詳細を表示できます。
  end

  def edit
    # 現在ログインしているユーザーの情報を取得して、@userに代入します。
    @user = current_user
  end
  
  def update
    # 現在ログインしているユーザーの情報を取得して、@userに代入します。
    @user = current_user
    # ユーザーの情報を更新し、更新が成功した場合はユーザーの詳細ページにリダイレクトします。
    # 更新が失敗した場合は、編集画面を再表示します。
    if @user.update(user_params)
      redirect_to user_path, notice: 'ユーザーを更新しました。'
    else
      render :edit
    end
  end
  
  private

  # ストロングパラメータ
  def user_params
    # ストロングパラメータを使用して、セキュリティ上の理由から許可された属性のみを受け入れます。
    # フォームから送信されたユーザー情報に対して、nameとemail属性のみを許可します。
    # これにより、不正なパラメータが送信された場合でも安全に処理できます。
    params.require(:user).permit(:name, :email)
  end
end
