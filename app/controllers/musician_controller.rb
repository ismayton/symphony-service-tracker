class MusicianController < ApplicationController 

    get '/musicians' do 
        @musicians = Musician.all.order(:name)
        erb :'/musicians/index'
      end 

    get '/musicians/:id' do
      @musician = Musician.find(params[:id])
      erb :'/musicians/show' 
    end 


end 
