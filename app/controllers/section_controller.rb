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

  


end 