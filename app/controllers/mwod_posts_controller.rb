class MwodPostsController < ApplicationController
  # GET /mwod_posts
  # GET /mwod_posts.json
  def index
    @mwod_posts = MwodPost.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mwod_posts }
    end
  end

  # GET /mwod_posts/1
  # GET /mwod_posts/1.json
  def show
    @mwod_post = MwodPost.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mwod_post }
    end
  end

  # GET /mwod_posts/new
  # GET /mwod_posts/new.json
  def new
    @mwod_post = MwodPost.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mwod_post }
    end
  end

  # GET /mwod_posts/1/edit
  def edit
    @mwod_post = MwodPost.find(params[:id])
  end

  # POST /mwod_posts
  # POST /mwod_posts.json
  def create
    @mwod_post = MwodPost.new(params[:mwod_post])

    respond_to do |format|
      if @mwod_post.save
        format.html { redirect_to @mwod_post, notice: 'Mwod post was successfully created.' }
        format.json { render json: @mwod_post, status: :created, location: @mwod_post }
      else
        format.html { render action: "new" }
        format.json { render json: @mwod_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mwod_posts/1
  # PUT /mwod_posts/1.json
  def update
    @mwod_post = MwodPost.find(params[:id])

    respond_to do |format|
      if @mwod_post.update_attributes(params[:mwod_post])
        format.html { redirect_to @mwod_post, notice: 'Mwod post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mwod_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mwod_posts/1
  # DELETE /mwod_posts/1.json
  def destroy
    @mwod_post = MwodPost.find(params[:id])
    @mwod_post.destroy

    respond_to do |format|
      format.html { redirect_to mwod_posts_url }
      format.json { head :no_content }
    end
  end
end
