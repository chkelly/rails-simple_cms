class PagesController < ApplicationController
      layout 'admin'
  
  def index
    list
    render('list')
  end
  
  def list
    @pages = Page.order("pages.position ASC")
  end
  
  def show
    @page = Page.find(params[:id])
  end
  
  def new
    @page = Page.new
    @page_count = Page.count + 1
    @subjects_all_collect = Subject.all.collect
  end
  
  def create
    #instantiate a new object using form parameters
    @page = Page.new(params[:page])
    #save the object
    if @page.save
      #if the save succeeds, redirect to the list action
      flash[:notice] = "page Created!"
      redirect_to(:action => 'list')
    else
      #if the save fails, redisplay the form so user can fix problems
      @page_count = Page.count + 1
      @subjects_all_collect = Subject.all.collect
      render('new')
    end
  end
  
  def edit
    @page = Page.find(params[:id])
    @page_count = Page.count
    @subjects_all_collect = Subject.all.collect
  end
  
  def update
    #Find a new object using form parameters
    @page = Page.find(params[:id])
    #save the object
    if @page.update_attributes(params[:page])
      #if the save succeeds, redirect to the list action
      flash[:notice] = "page Updated!!"
      
      redirect_to(:action => 'show', :id => @page.id)
    else
      #if the save fails, redisplay the form so user can fix problems
      @page_count = Page.count
      @subjects_all_collect = Subject.all.collect
      render('edit')
    end
  end
  
  def delete
    @page = Page.find(params[:id])
  end
  
  def destroy
    Page.find(params[:id]).destroy
    flash[:notice] = "page Destroyed!"
    redirect_to(:action => 'list')
  end
end
