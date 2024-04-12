# まず、ベースイメージの指定を実施。
FROM ruby:2.7

# API開発を実施する際などは、以下４行を設定する。
# curlコマンドを使用して、Yarnの公開鍵をダウンロードし、apt-keyに追加します。
# echoコマンドを使用して、Yarnのリポジトリを sources.list.d/yarn.list ファイルに追加します。
# apt-getコマンドを使用して、パッケージリストを最新の状態に更新します。
# apt-getコマンドを使用して、nodejsとyarnパッケージをインストールします。
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y nodejs yarn

# 今回作業する仮想環境の方のディレクトリを指定している。＊ない場合は作成される。
WORKDIR /app

# 今回以下のローカルのsrcディレクトリにソースコードを記載するので、そちらを仮想環境のディレクトリの/appにコピーするという意味。
COPY ./src /app

# bundle install先のディレクトリを指定する。
# Ruby関連のライブラリをインストールする。
# こちらも仮想環境のディレクトリに反映される。
RUN bundle config --local set path 'vendor/bundle' \
  && bundle install
