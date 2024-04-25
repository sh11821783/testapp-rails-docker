class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    # articlesテーブルを作成する
    create_table :articles do |t|
      # タイトルを表す文字列型のカラムを追加
      t.string :title
      # 本文を表すテキスト型のカラムを追加
      t.text :body
      # 記事に関連するユーザーのIDを表す整数型のカラムを追加
      t.integer :user_id

      # 作成日時と更新日時を自動的に管理するためのカラムを追加
      t.timestamps
    end
  end
end
