class MusicianController < ApplicationController 

    get '/musicians' do 
        @musicians = Musician.all.order(:name)
        erb :'/musicians/index'
    end 

    get '/musicians/new' do
      @sections = Section.all 
      @programs = Program.all
      erb :'/musicians/new'
    end

    post '/musicians/new' do
      if params[:musician] && params[:section]
        @musician = Musician.create(name: params[:musician][:name])
        @musician.section = Section.find_by(name: params[:musician][:section])
        params[:musician][:programs].each do |program_name|
          @musician.programs << Program.find_by(name: program_name)
        end

        @musician.save

        redirect to "/musicians/#{@musician.id}"
      else
        redirect to "/musicians/new"
      end
    end 

    get '/musicians/:id' do
      @musician = Musician.find(params[:id])
      erb :'/musicians/show' 
    end 

     

end 
