# Railsアプリケーションのルーティングを定義しています。
# ユーザーが特定のURLにアクセスした際に、どのコントローラーのどのアクションを呼び出すかを指定します。
Rails.application.routes.draw do
  # 'home/top' にアクセスがあった場合、'home' コントローラーの 'top' アクションを呼び出します。
  # これは、アプリケーションのルートURLに対する設定で、ユーザーが最初にアプリケーションにアクセスしたときに表示されるページを指定します。
  root to: 'home#top'

  # Devise gem が提供するユーザー認証関連のルーティングを自動的に生成します。
  # これにより、ユーザーのサインアップやログインなどの認証機能を実装できます。
  devise_for :users

  # resource メソッドは、単一のリソースに対する CRUD 操作を扱う際に使用されます。
  # これは、特定の画面での新規作成、編集、表示、更新などの操作を可能にします。
  # exceptは、指定したアクションは除外するという意味。
  resource :user, except: [:new, :create, :destroy]

  # 'articles' リソースに対するルーティングを設定します。
  # これにより、articlesコントローラーのindex、show、new、create、edit、update、destroyアクションに対応するURLが生成されます。
  resources :articles

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
