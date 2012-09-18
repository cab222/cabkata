class MwodTagsController < ApplicationController
  # GET /mwod_tags
  # GET /mwod_tags.json
  def index
    @mwod_tags = MwodTag.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mwod_tags }
    end
  end

  # GET /mwod_tags/1
  # GET /mwod_tags/1.json
  def show
    @mwod_tag = MwodTag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mwod_tag }
    end
  end

  # GET /mwod_tags/new
  # GET /mwod_tags/new.json
  def new
    @mwod_tag = MwodTag.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mwod_tag }
    end
  end

  # GET /mwod_tags/1/edit
  def edit
    @mwod_tag = MwodTag.find(params[:id])
  end

  # POST /mwod_tags
  # POST /mwod_tags.json
  def create
    @mwod_tag = MwodTag.new(params[:mwod_tag])

    respond_to do |format|
      if @mwod_tag.save
        format.html { redirect_to @mwod_tag, notice: 'Mwod tag was successfully created.' }
        format.json { render json: @mwod_tag, status: :created, location: @mwod_tag }
      else
        format.html { render action: "new" }
        format.json { render json: @mwod_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mwod_tags/1
  # PUT /mwod_tags/1.json
  def update
    @mwod_tag = MwodTag.find(params[:id])

    respond_to do |format|
      if @mwod_tag.update_attributes(params[:mwod_tag])
        format.html { redirect_to @mwod_tag, notice: 'Mwod tag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mwod_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mwod_tags/1
  # DELETE /mwod_tags/1.json
  def destroy
    @mwod_tag = MwodTag.find(params[:id])
    @mwod_tag.destroy

    respond_to do |format|
      format.html { redirect_to mwod_tags_url }
      format.json { head :no_content }
    end
  end
end
