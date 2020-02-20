#!/bin/bash

set -ex;

########## for WP-CLI ##################
### https://developer.wordpress.org/cli/commands/

### WPをインストールするパス
WP_INSTALL_DIR=/var/www/html/wp
### サイトURL： .env で設定したポート、上記パスと合わせる
WP_URL=localhost:8102/wp
### インストールするプラグイン： 同時に有効化する時は 1 、 インストールのみなら 0（1以外）
declare -A PLUGINS;
PLUGINS=(
  # ["advanced-custom-fields"]=0
  ["classic-editor"]=0
  # ["duplicate-post"]=0
  ["query-monitor"]=0
  ["show-current-template"]=0
  # ["tinymce-advanced"]=0
  # ["transients-manager"]=0
  # ["wp-crontrol"]=0
  ["wp-multibyte-patch"]=1
)



###### WPのダウンロード： PHP5.6未満は WP5.1.xまで
### Releases: https://ja.wordpress.org/download/releases/
wp core download \
  --locale=ja \
  --version=4.9.8 \
  --path=${WP_INSTALL_DIR} \
  --allow-root


###### wp-configの設定
wp config create \
  --dbname=wordpress \
  --dbuser=wordpress \
  --dbpass=wordpress \
  --dbprefix=wp_ \
  --dbhost=wpdb \
  --path=${WP_INSTALL_DIR} \
  --allow-root \
  --extra-php <<PHP
/* WP-CLI config create --extra-php */
define('WP_DEBUG', true);
define('JETPACK_DEV_DEBUG', true);
define('SAVEQUERIES', false);
PHP


###### WPのインストール
wp core install \
  --path=${WP_INSTALL_DIR} \
  --url=${WP_URL} \
  --title=テスト用WordPress \
  --admin_user=admin \
  --admin_password=admin \
  --admin_email=admin@docker-cli.test \
  --allow-root


###### 検索エンジンがサイトをインデックスしないようにする
wp option update blog_public 0 --path=${WP_INSTALL_DIR} --allow-root


###### プラグインのインストール #####
for plugin in ${!PLUGINS[@]}; do
  if [ 1 -eq ${PLUGINS[$plugin]} ]; then
    wp plugin install $plugin --activate --path=${WP_INSTALL_DIR} --allow-root
  else
    wp plugin install $plugin --path=${WP_INSTALL_DIR} --allow-root
  fi
done

