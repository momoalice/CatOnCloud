class Post < ActiveRecord::Base
	serialize :imageURLS, Array
	serialize :videoURLS, Array
end
