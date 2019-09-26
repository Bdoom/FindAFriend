# frozen_string_literal: true

host 'www.uwuanimu.com'

sitemap :uwuanimu do
  url root_url, last_mod: Time.now, change_freq: 'daily', priority: 1.0
end

sitemap_for User.all
sitemap_for Photo.all
sitemap_for PhotoAlbum.all
sitemap_for BoardThread.all
sitemap_for Board.all
sitemap_for Conversation.all

ping_with "http://#{host}/sitemaps/sitemap.xml"
