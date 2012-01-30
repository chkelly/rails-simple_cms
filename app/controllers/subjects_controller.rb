class SubjectsController < ApplicationController
  
  def index
    list
    render('list')
  end
  
  def list
    @subjects = Subject.order("subjects.position ASC")
  end
  
  def show
    @subject = Subject.find(params[:id])
  end
  
  def new
    @subject = Subject.new
  end
  
  def create
    #instantiate a new object using form parameters
    @subject = Subject.new(params[:subject])
    #save the object
    if @subject.save
      #if the save succeeds, redirect to the list action
      redirect_to(:action => 'list')
    else
      #if the save fails, redisplay the form so user can fix problems
      render('new')
    end
  end
end
