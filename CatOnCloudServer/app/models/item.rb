class Item < ActiveRecord::Base
	has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }
	validates_attachment :picture, presence: true 
	do_not_validate_attachment_file_type :picture
end
