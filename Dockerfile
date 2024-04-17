# ベースイメージとして、指定したバージョンのNode.jsを使用します。
FROM ruby:2.7

# Node.jsのバージョンを指定してインストールします
# Node.jsの公式Dockerイメージは、必要なNode.jsバージョンを提供しています。
# ここでは、14.x系のNode.jsをインストールしています。
# https://hub.docker.com/_/node
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash - \
  && apt-get install -y nodejs

# Yarnの公開鍵をダウンロードし、apt-keyに追加します。
# Yarnのリポジトリを sources.list.d/yarn.list ファイルに追加します。
# apt-getコマンドを使用して、パッケージリストを最新の状態に更新します。
# apt-getコマンドを使用して、yarnパッケージをインストールします。
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y yarn

# 今回作業する仮想環境の方のディレクトリを指定している。＊ない場合は作成される。
WORKDIR /app

# 今回以下のローカルのsrcディレクトリにソースコードを記載するので、そちらを仮想環境のディレクトリの/appにコピーするという意味。
COPY ./src /app

# bundle install先のディレクトリを指定する。
# Ruby関連のライブラリをインストールする。
# こちらも仮想環境のディレクトリに反映される。
RUN bundle config --local set path 'vendor/bundle' \
  && bundle install

# Webpackerのインストール
RUN bundle exec rails webpacker:install