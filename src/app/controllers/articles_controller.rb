# ArticlesController: 記事関連の操作を処理するコントローラークラス
# ApplicationControllerを継承している。
class ArticlesController < ApplicationController
  # アクション: 記事一覧を表示するページ
  def index
    # データベースから全ての記事を取得し、@articlesという変数に代入する
    @articles = Article.all
  end

  # アクション: 特定の記事を表示するページ
  def show
    # 特定のIDに対応する記事をデータベースから取得し、インスタンス変数に代入する
    @article = Article.find(params[:id])
  end

  # アクション: 新しい記事を作成するページを表示する
  def new
    # 新しい記事のための空のArticleオブジェクトを生成し、インスタンス変数に代入する
    @article = Article.new
  end

  # アクション: 新しい記事をデータベースに保存する
  def create
    # フォームから送信された記事のパラメータを使って、新しいArticleオブジェクトを作成する
    @article = Article.new(article_params)
    # 現在ログインしているユーザーのIDを記事に関連付ける
    @article.user_id = current_user.id
    # 記事をデータベースに保存し、保存が成功した場合は記事の詳細ページにリダイレクトする
    if @article.save
      # 記事の作成が成功した場合の処理
      redirect_to article_path(@article), notice: '投稿に成功しました。'
    else
      # 保存が失敗した場合は、新規記事作成ページを再表示する
      render :new
    end
  end

  # アクション: 既存の記事を編集するページを表示する
  def edit
    # 編集対象の記事を特定し、インスタンス変数に代入する
    @article = Article.find(params[:id])
    # 現在ログインしているユーザーが記事の所有者でない場合は、不正なアクセスとしてリダイレクトする
    if @article.user_id != current_user.id
      redirect_to article_path, alert: '不正なアクセスです。もう一度やり直して下さい。'
    end
  end

  # アクション: 既存の記事を更新する
  def update
    # 編集対象の記事を特定し、インスタンス変数に代入する
    @article = Article.find(params[:id])
    # フォームから送信された記事のパラメータを使って、記事を更新する
    if @article.update(article_params)
      # 更新が成功した場合は、記事の詳細ページにリダイレクトする
      redirect_to article_path(@article), notice: "更新完了いたしました。"
    else
      # 更新が失敗した場合は、記事の編集ページを再表示する
      render :edit
    end
  end

  # アクション: 既存の記事を削除する
  def destroy
    # 削除対象の記事を特定し、ローカル変数に代入する
    article = Article.find(params[:id])
    # 記事をデータベースから削除する
    article.destroy
    # 記事一覧ページにリダイレクトする
    # 「#{article.title}」と書く事で、削除時のメッセージにタイトル名をつけることができる
    redirect_to articles_path, notice: "タイトル名『#{article.title}』を削除いたしました。"
  end

  # privateキーワードは、以下に続くメソッドがプライベートメソッドであることを示します。
  # つまり、外部から直接呼び出すことはできず、クラス内部でのみ利用可能です。
  private

  # Strong Parametersを使用して、フォームから受け取るパラメータを制限する
  def article_params
    params.require(:article).permit(:title, :body)
  end
end
