class Newcat < ApplicationRecord
	serialize :pics, Array
	serialize :location, Array
end
