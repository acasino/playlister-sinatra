class SongGenre < ActiveRecord::Base
    #song has many genres and genre has many songs
    belongs_to :genre
    belongs_to :song
end