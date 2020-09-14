class MusicianController < ApplicationController 

  get '/musicians' do 
      @musicians = Musician.all_sorted_by_last
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
   
  get '/musicians/:id/edit' do
    @musician = Musician.find(params[:id])
    @sections = Section.all 
    @programs = Program.all
    erb :'/musicians/edit' 
  end

  patch '/musicians/:id/edit' do 
    if !params[:musician][:name].empty?
      @musician = Musician.find(params[:id])
      @musician.update(name: params[:musician][:name])
      @musician.section = Section.find_by(name: params[:musician][:section])

      if params[:musician][:programs]
        @musician.programs.clear
        params[:musician][:programs].each do |program_name|
          @musician.programs << Program.find_by(name: program_name)
        end
      end

      @musician.save
      redirect to "/musicians/#{params[:id]}"
    else
      redirect to "/musicians/#{params[:id]}/edit"
    end
  end 

  get '/musicians/:id/delete' do 
    Musician.find(params[:id]).delete
    redirect to '/musicians'
  end 

end 
