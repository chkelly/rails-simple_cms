class SectionsController < ApplicationController
    layout 'admin'
  
  before_filter :confirm_logged_in, :except => [:login, :attempt_login, :logout]
  
  def index
    list
    render('list')
  end
  
  def list
    @sections = Section.order("sections.position ASC")
  end
  
  def show
    @section = Section.find(params[:id])
  end
  
  def new
    @section = Section.new
    @sections_count = Section.count + 1
    @pages_all_collect = Page.all.collect
  end
  
  def create
    #instantiate a new object using form parameters
    @section = Section.new(params[:section])
    #save the object
    if @section.save
      #if the save succeeds, redirect to the list action
      flash[:notice] = "section Created!"
      redirect_to(:action => 'list')
    else
      #if the save fails, redisplay the form so user can fix problems
      @sections_count = Section.count + 1
      @pages_all_collect = Page.all.collect
      render('new')
    end
  end
  
  def edit
    @section = Section.find(params[:id])
    @sections_count = Section.count
    @pages_all_collect = Page.all.collect
  end
  
  def update
    #Find a new object using form parameters
    @section = Section.find(params[:id])
    #save the object
    if @section.update_attributes(params[:section])
      #if the save succeeds, redirect to the list action
      flash[:notice] = "section Updated!"
      redirect_to(:action => 'show', :id => @section.id)
    else
      #if the save fails, redisplay the form so user can fix problems
      @sections_count = Section.count
      @pages_all_collect = Page.all.collect
      render('edit')
    end
  end
  
  def delete
    @section = Section.find(params[:id])
  end
  
  def destroy
    Section.find(params[:id]).destroy
    flash[:notice] = "section Destroyed!"
    redirect_to(:action => 'list')
  end
end
