class GigsController < ApplicationController
  before_filter :protect, :except => :index

  # GET /gigs
  # GET /gigs.xml
  def index
    @gigs = Gig.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @gigs }
    end
  end

  # GET /gigs/1
  # GET /gigs/1.xml
  def show
    @gig = Gig.find(params[:id])
    @venue = Venue.find_by_id(@gig.venue_id)
    if @gig
      @title = "Musigigs Gig Profile for #{@venue.name}"
    else
      flash[:notice] = "No band #{@venue.name} at Musigigs!"
      redirect_to hub_url
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @gig }
    end
  end

  # GET /gigs/new
  # GET /gigs/new.xml
  def new
    @user = User.find(session[:user_id])
    @gig = Gig.new
    @venue = Venue.find_by_id(params[:id])
#    @venue = @user.venues.find(params[:id])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @gig }
    end
  end

  # GET /gigs/1/edit
  def edit
    @gig = Gig.find(params[:id])
    @venue = Venue.find_by_id(@gig.venue_id)
    @band = Band.find_by_id(@gig.band_id)
    @title = "Edit Gig"
  end

  # POST /gigs
  # POST /gigs.xml
  def create
    @user = User.find(session[:user_id])
    @venue = Venue.find(params[:venue_id])
    
    @gig = Gig.new(params[:gig])    
    @gig.venue_id = @venue.id
    @gig.band_id = '0'
    #@gig.date = Date.new(params[:time]['date(1i)'].to_i, params[:time]['date(2i)'].to_i, params[:time]['date(3i)'].to_i)
    #@gig.time = Time.new
    #@gig.time = @gig.time.change( :year  => params[:gig]['time(1i)'].to_s,
    #                              :month => params[:gig]['time(2i)'].to_s,
    #                              :day   => params[:gig]['time(3i)'].to_s,
    #                              :hour  => params[:gig]['time(4i)'].to_s,
    #                              :min   => params[:gig]['time(5i)'].to_s )                                

    respond_to do |format|
      if @gig.save
        @venue.gigs << @gig
        @venue.save!
        flash[:notice] = 'Gig was successfully created.'
        format.html { redirect_to(@gig) }
        format.xml  { render :xml => @gig, :status => :created, :location => @gig }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @gig.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /gigs/1
  # PUT /gigs/1.xml
  def update
    @gig = Gig.find(params[:id])
    
    respond_to do |format|
      if @gig.update_attributes(params[:gig])
        flash[:notice] = 'Gig was successfully updated.'
        format.html { redirect_to(@gig) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @gig.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /gigs/1
  # DELETE /gigs/1.xml
  def destroy
    @gig = Gig.find(params[:id])
    @gig.destroy

    respond_to do |format|
      format.html { redirect_to(gigs_url) }
      format.xml  { head :ok }
    end
  end
end
