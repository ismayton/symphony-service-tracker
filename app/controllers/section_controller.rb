class SectionController < ApplicationController 

    get '/sections' do 
        @sections = Section.all
        erb :'/sections/index'
      end 

    get '/sections/:id' do 
      @section = Section.find(params[:id])
      erb :'/sections/show'
    end 
end 