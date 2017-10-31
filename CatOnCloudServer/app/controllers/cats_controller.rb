class CatsController < ApplicationController

	def create_cat
		@cat = Cat.new
		@cat.name = params["name"]
		@cat.description = params["description"]
		urls = []
		for i in params["image_ids"]
      		@item = Item.find(i)
      		urls.push(@item.picture.url(:medium))
    	end
		@cat.picsUrl = urls
		@cat.rate = params["rate"]
		@cat.location = params["location"]
		@cat.subs = 0
		@cat.owner_id = params["owner_id"]
		if @cat.save
	      render json: {id: @cat.id}
	    else
	      render json: {status: :unprocessable_entity, err: @cat.errors}
	    end
	end

	# get sorted post of a specific cat
	def get_post
		id = params["id"]
		posts = []
		Post.where("cat_id = #{id}").find_each do |post|
			posts.push(post)
		end
		posts.sort!{|a,b| a.time <=> b.time}
		posts = posts[1..[10,posts.count].min].reverse
		render json:posts
	end


	def get_cat 
		id = params["id"]
		render json: Cat.find(id)
	end
		

	def getcats
		render json: Cat.all
	end

end
