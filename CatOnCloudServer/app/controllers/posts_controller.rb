class PostsController < ApplicationController

  # POST /posts
  def create
    @post = Post.new
    @post.time = Time.now
    @post.likes = 0
    @post.cat_id = params["cat_id"]
    @post.words = params["words"]
    image_urls = []
    video_urls = []

    for i in params["media_ids"]
      @item = Item.find(i)
      if @item != nil
        if @item.media_type == 0
          image_urls.push(@item.picture.url(:medium))
        else 
          video_urls.push(@item.picture.url(:medium))
        end
      end
    end
    @post.imageURLS = image_urls 
    @post.videoURLS = video_urls

    if @post.save
      render json: {id:@post.id}
    else
      render json: {status: :unprocessable_entity, err: @post.errors}
    end
  end

  def liked
    @post = Post.find(params["id"])
    if @post != nil 
      @post.likes += 1
      if @post.save
        render json: {status: :created, location: @post}
      else
        render json: {status: :unprocessable_entity, err: @post.errors}
      end
    end
  end

end
