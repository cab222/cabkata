class MwodVideoLinksController < ApplicationController
  # GET /mwod_video_links
  # GET /mwod_video_links.json
  def index
    @mwod_video_links = MwodVideoLink.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mwod_video_links }
    end
  end

  # GET /mwod_video_links/1
  # GET /mwod_video_links/1.json
  def show
    @mwod_video_link = MwodVideoLink.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mwod_video_link }
    end
  end

  # GET /mwod_video_links/new
  # GET /mwod_video_links/new.json
  def new
    @mwod_video_link = MwodVideoLink.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mwod_video_link }
    end
  end

  # GET /mwod_video_links/1/edit
  def edit
    @mwod_video_link = MwodVideoLink.find(params[:id])
  end

  # POST /mwod_video_links
  # POST /mwod_video_links.json
  def create
    @mwod_video_link = MwodVideoLink.new(params[:mwod_video_link])

    respond_to do |format|
      if @mwod_video_link.save
        format.html { redirect_to @mwod_video_link, notice: 'Mwod video link was successfully created.' }
        format.json { render json: @mwod_video_link, status: :created, location: @mwod_video_link }
      else
        format.html { render action: "new" }
        format.json { render json: @mwod_video_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mwod_video_links/1
  # PUT /mwod_video_links/1.json
  def update
    @mwod_video_link = MwodVideoLink.find(params[:id])

    respond_to do |format|
      if @mwod_video_link.update_attributes(params[:mwod_video_link])
        format.html { redirect_to @mwod_video_link, notice: 'Mwod video link was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mwod_video_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mwod_video_links/1
  # DELETE /mwod_video_links/1.json
  def destroy
    @mwod_video_link = MwodVideoLink.find(params[:id])
    @mwod_video_link.destroy

    respond_to do |format|
      format.html { redirect_to mwod_video_links_url }
      format.json { head :no_content }
    end
  end
end
