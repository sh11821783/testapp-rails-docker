class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # デフォルトの Devise モジュールを含みます。利用可能な他のモジュールは以下の通りです:
  # :confirmable, :lockable, :timeoutable, :trackable, :omniauthable
  # 
  validates :name, presence: true
  # ユーザー名が存在することを検証します。
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Devise モジュールを使用して、ユーザーの認証に関連する機能を追加します。
  # :database_authenticatable: データベースを使用した認証を提供します。
  # :registerable: 新規登録機能を提供します。
  # :recoverable: パスワードのリセット機能を提供します。
  # :rememberable: ログイン情報の記憶機能を提供します。
  # :validatable: パスワードやメールアドレスのバリデーションを提供します。
  has_many :articles, dependent: :destroy
  # ユーザーが複数の記事を持つ関連を定義します。
  # dependent: :destroy は、ユーザーが削除された場合、関連するすべての記事も削除されることを示します。
end
