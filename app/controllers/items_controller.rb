class ItemsController < ApplicationController

  def new
    @pages = Page.all
    @item = Item.new
  end
  def create
    @item = Item.new(params[:item])
    @page = Page.find(@item.page_id)
    respond_to do |format|
      if @item.save
        flash[:notice] = 'Page was successfully created.'
        format.html { redirect_to(:controller=>:pages, :action=>:show,:id=>@page.name) }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end
  def show
    @item = Item.find(params[:id])
  end
end

