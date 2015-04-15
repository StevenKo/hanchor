class Video < ActiveRecord::Base
  # attr_accessible :title, :body

  def youtube_embed_link
    /v=(.{11})/ =~ link
    "https://www.youtube.com/embed/#{$1}"
  end
end
