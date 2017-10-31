require "google/cloud/vision"


class UsersController < ApplicationController
    
    def info
        @user = User.find(params["id"])
        render json: @user
    end
    
    def create
        @user = User.new
        @user.name = params["name"]
        @user.intro = params["intro"]
        @user.password = params["pw"]
        @user.sublist = []
        if @user.save
            render json: {id:@user.id}
            else
            render json: {status: :unprocessable_entity, err: @user.errors}
        end
    end
    
    def subscribe
        cat_id = params["cat_id"]
        @user = User.find(params["user_id"])
        @cat = Cat.find(cat_id)
        if @user != nil && @cat != nil
            if ! @user.sublist.include? cat_id
                @user.sublist.push(cat_id)
                @cat.subs = 1 + @cat.subs.to_i
            end
            @cat.save
            @user.save
        end
    end
    
    def subscribed_cats
        @user = User.find(params["id"])
        res = []
        puts(@user.sublist)
        if @user != nil
            for id in @user.sublist
                res.push(Cat.find(id))
            end
        end
        render json: res
    end
    
    def owned_cats
        id = params["id"]
        res = []
        Cat.where("owner_id = #{id}").find_each do |cat|
            res.push(cat)
        end
        render json: res
    end
    
    def recommanded_cats
        res = []
        data = {}
        id = params["id"]
        fid = -1
        @user = User.find(id)
        project_id = "catoncloud-183615"
        vision = Google::Cloud::Vision.new project: project_id
        Cat.where("owner_id != #{fid}").find_each do |cat|
            
            if ! @user.sublist.include? cat.id
                res.push(cat)
            end
            target = Cat.find(4)
            res.push(target)
            res.each do |cat|
                data[cat] = (vision.image cat.picsUrl[0].gsub(/ *\d+$/, '').chomp('?')+".jpg").labels
            end
            bestImages = {}
            
            res.each do |cat|
                puts(data)
                data.fetch(cat,nil).each do |dest_label|
                    data.fetch(target, nil).each do |original_label|
                        # if (origin_label.desciption == dest_label.description)
                            diff = (1.0 - (dest_label.score - origin_label.score))
                            bestImages[cat] = bestImages.fetch(cat,1.0) * diff
                        # end
                    end
                end
            end
        end
        res = Hash[bestImages.sort.reverse].keys[1..3]
        render json: res
    end
    
end
