#!/bin/bash

set -ex;

########## for WP-CLI ##################
### https://developer.wordpress.org/cli/commands/

### WPをインストールしたパス： .env で設定したパスと合わせる
WP_INSTALL_DIR=/var/www/html/wp
### サイトURL： .env で設定したポート、サブディレクトリと合わせる
WP_URL=localhost:8101/wp
### インストールするプラグイン： 同時に有効化する時は 1 、 インストールのみなら 0（1以外）
declare -A PLUGINS;
PLUGINS=(
  # ["duplicate-post"]=0
  # ["advanced-custom-fields"]=0
  ["classic-editor"]=0
  # ["tinymce-advanced"]=0
  ["wp-multibyte-patch"]=1
)


###### WPのダウンロード（必要ならアンコメント） #####
###### Releases: https://ja.wordpress.org/download/releases/
# wp core download \
#   --locale=ja \
#   --version=4.9.9 \
#   --path=${WP_INSTALL_DIR} \
#   --force \
#   --allow-root


###### WPのインストール： タイトル、ユーザー等の設定 #####
wp core install \
  --path=${WP_INSTALL_DIR} \
  --url=${WP_URL} \
  --title=テスト用WordPress \
  --admin_user=admin \
  --admin_password=admin \
  --admin_email=admin@docker.test \
  --allow-root


###### 検索エンジンがサイトをインデックスしないようにする
wp option update blog_public 0 --allow-root


###### プラグインのインストール #####
for plugin in ${!PLUGINS[@]}; do
  if [ 1 -eq ${PLUGINS[$plugin]} ]; then
    wp plugin install $plugin --activate --path=${WP_INSTALL_DIR} --allow-root
  else
    wp plugin install $plugin --path=${WP_INSTALL_DIR} --allow-root
  fi
done

