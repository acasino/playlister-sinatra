require 'rack-flash'


class SongsController < ApplicationController
    use Rack::Flash


    get '/songs' do
        @songs = Song.all 
        erb :'/songs/index'
    end

    get '/songs/new' do
        erb :'/songs/new'
    end

    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        erb :'/songs/show'
    end

    post '/songs' do
        @song = Song.create(params[:song])
        @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
        @song.genre_ids = params[:genres]
        @song.save

        #flash
        flash[:message] = "Successfully created song."
        redirect("/songs/#{@song.slug}")
    end


    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        erb :'/songs/edit'
    end

    patch '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        @song.update(params[:song])
        @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
        @song.genre_ids = params[:genres]
        @song.save

        #flash
        flash[:message] = "Successfully updated song."
        redirect("/songs/#{@song.slug}")
    end

    # patch '/figures/:id' do
    #     @figure = Figure.find_by_id(params[:id])
    #     @figure.update(params[:figure])
    #     unless params[:title][:name].empty?
    #       @figure.titles << Title.create(params[:title])
    #     end
    #     unless params[:landmark][:name].empty?
    #       @figure.landmarks << Landmark.create(params[:landmark])
    #     end
    #     @figure.save
    #     redirect to "/figures/#{@figure.id}"
    #   end



end