class SubjectsController < ApplicationController
  
  layout 'admin'
  
  before_filter :confirm_logged_in, :except => [:login, :attempt_login, :logout]
  
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
    @subject_count = Subject.count + 1
  end
  
  def create
    #instantiate a new object using form parameters
    @subject = Subject.new(params[:subject])
    #save the object
    if @subject.save
      #if the save succeeds, redirect to the list action
      flash[:notice] = "Subject Created!"
      redirect_to(:action => 'list')
    else
      #if the save fails, redisplay the form so user can fix problems
      @subject_count = Subject.count + 1
      render('new')
    end
  end
  
  def edit
    @subject = Subject.find(params[:id])
    @subject_count = Subject.count
  end
  
  def update
    #Find a new object using form parameters
    @subject = Subject.find(params[:id])
    #save the object
    if @subject.update_attributes(params[:subject])
      #if the save succeeds, redirect to the list action
      flash[:notice] = "Subject Updated!"
      redirect_to(:action => 'show', :id => @subject.id)
    else
      #if the save fails, redisplay the form so user can fix problems
      @subject_count = Subject.count
      render('edit')
    end
  end
  
  def delete
    @subject = Subject.find(params[:id])
  end
  
  def destroy
    Subject.find(params[:id]).destroy
    flash[:notice] = "Subject Destroyed!"
    redirect_to(:action => 'list')
  end
end
