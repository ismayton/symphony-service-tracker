class SectionController < ApplicationController 

  get '/sections' do 
      @sections = Section.all
      erb :'/sections/index'
  end 
  
  get '/sections/new' do
    @musicians = Musician.all_sorted_by_last
    erb :'/sections/new'
  end

  post '/sections/new' do 
    if params[:section]
      @section = Section.create(name: params[:section][:name])
      params[:section][:musicians].each do |musician_name|
        @section.musicians << Program.find_by(name: musician_name)
      end
      @section.save

      redirect to "/sections/#{@section.id}"
    else
      redirect to "/sections/new"
    end
  end 

  get '/sections/:id' do 
    @section = Section.find(params[:id])
    erb :'/sections/show'
  end 

  get '/sections/:id/edit' do
    @section = Section.find(params[:id])
    @musicians = Musician.all 
    erb :'/sections/edit' 
  end

  patch '/sections/:id/edit' do 
    if !params[:section][:name].empty?
      @section = Section.find(params[:id])
      @section.update(name: params[:section][:name])

      if params[:section][:musicians]
        @section.musicians.clear
        params[:section][:musicians].each do |musician_name|
          @section.musicians << Musician.find_by(name: musician_name)
        end
      end

      @section.save
      redirect to "/sections/#{params[:id]}"
    else
      redirect to "/sections/#{params[:id]}/edit"
    end
  end 

  get '/sections/:id/delete' do 
    Section.find(params[:id]).delete
    redirect to '/sections'
  end 


end 