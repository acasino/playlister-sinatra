class Artist < ActiveRecord::Base
    #artist has multiple songs and multiple genres
    has_many :songs
    has_many :genres, through: :songs

    #slugify
    def slug
        name.downcase.gsub(" ","-")
    end

    def self.find_by_slug(slug)
        Artist.all.find{|artist| artist.slug == slug}
    end

end