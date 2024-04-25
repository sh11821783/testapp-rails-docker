class Article < ApplicationRecord
  # 記事は一つのユーザーに所属することを示します。
  belongs_to :user
  
  with_options presence: true do
    # 以下のバリデーションが全ての属性に適用されることを示します。
    # presence: true は、それぞれの属性が空でないことを検証します。
    validates :title
    # タイトルが存在することを検証します。
    validates :body
    # 本文が存在することを検証します。
  end
end
