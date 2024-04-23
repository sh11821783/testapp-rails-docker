# ベースイメージとして、Rubyのバージョン2.7を使用します。
FROM ruby:2.7

# Node.jsとYarnをインストールします。
# Node.jsは、JavaScriptの実行環境で、Webアプリケーションの開発に必要です。
# Yarnは、Node.jsのパッケージマネージャで、JavaScriptの依存関係を管理します。
RUN \
    # Node.jsのセットアップスクリプトをダウンロードし、実行します。
    curl -fsSL https://deb.nodesource.com/setup_14.x | bash - \
    # Node.jsをインストールします。
    && apt-get install -y nodejs \
    # Yarnの公開鍵をダウンロードし、apt-keyに追加します。
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    # Yarnのリポジトリをaptのソースリストに追加します。
    && echo "deb https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list \
    # aptのパッケージリストを最新の状態に更新します。
    && apt-get update -qq \
    # Yarnをインストールします。
    && apt-get install -y yarn

# 作業ディレクトリを/appに設定します。
WORKDIR /app

# ローカルのsrcディレクトリの中身をコピーして/appに配置します。
COPY ./src /app

RUN \
    # Rubyの依存関係をインストールします。
    # Gemfile.lockに記述されたGemがインストールされ、インストール先はvendor/bundleになります。
    bundle config --local set path 'vendor/bundle' \
    && bundle install \
    # RailsのWebpackerをインストールします。
    # Webpackerは、フロントエンドリソース（JavaScriptやCSSなど）を管理するGemです。
    && bundle exec rails webpacker:install
