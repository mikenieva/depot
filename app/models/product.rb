class Product < ActiveRecord::Base
	# validates() method is the standard Rails validator
	# It will check one or more model fieldds against one or more conditions

	# presence: true tells the validator to check that each of the named fields is present
	# and its contents are not empty.

	validates :title, :description, :image_url, presence: true

	# numericality() verifies that the price is a valid, positive number.
	validates :price, numericality: {greater_than_or_equal_to: 0.01}

	# We want to make sure each product has a unique title.
	validates :title, uniqueness: true, length: { minimum: 10 }

	# We need to validate the URL entered for the image is valid.
	# "format" matches a field against a regex
	validates :image_url, allow_blank: true, format: {
		with: %r{\.(gif|jpg|png)\Z}i,
		message: 'must be a URL for GIF, JPG or PNG image.'
	}

	def self.latest
		Product.order(:updated_at).last
	end

end
