class ProgramController < ApplicationController 

    get '/programs' do 
      if !logged_in?
        redirect to '/'
      end 

        @programs = Program.all
        erb :'/programs/index'
    end 
    
    get '/programs/new' do
      if !admin?
        redirect to '/'
      end

      @musicians = Musician.all_sorted_by_last
      erb :'/programs/new'
    end
  
    post '/programs/new' do 
      if !params[:program][:name].empty? && !params[:program][:services].empty?
        @program = Program.create(name: params[:program][:name])
        @program.services = params[:program][:services].to_i
        
        if params[:program][:musicians]
            params[:program][:musicians].each do |musician_name|
            @program.musicians << Musician.find_by(name: musician_name)
            end
        end 

        @program.save
  
        redirect to "/programs/#{@program.id}"
      else
        redirect to "/programs/new"
      end
    end 
  
    get '/programs/:id' do 
      if !logged_in?
        redirect to '/'
      end 

      @program = Program.find(params[:id])
      erb :'/programs/show'
    end 
  
    get '/programs/:id/edit' do
      if !admin?
        redirect to '/'
      end

      @program = Program.find(params[:id])
      @musicians = Musician.all 
      erb :'/programs/edit' 
    end
  
    patch '/programs/:id/edit' do 
      if !params[:program][:name].empty?
        @program = Program.find(params[:id])
        @program.update(name: params[:program][:name])
  
        binding.pry
        @program.musicians.clear
        if !!params[:program][:musicians]
          params[:program][:musicians].each do |musician_name|
            @program.musicians << Musician.find_by(name: musician_name)
          end
        end
  
        @program.save
        redirect to "/programs/#{params[:id]}"
      else
        redirect to "/programs/#{params[:id]}/edit"
      end
    end 
  
    get '/programs/:id/delete' do 
      if !admin?
        redirect to '/'
      end
      
      Program.find(params[:id]).delete
      redirect to '/programs'
    end 

  end 