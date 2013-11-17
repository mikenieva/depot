# This is the file that Rails created to hold the unit tests
# for the model we created earlier with the generate
# script
require 'test_helper'

# ProductTest is a subclass of ActiveSupport::TestCase.
# ActiveSupport::TestCase is a subclass of the MiniTest::Unit::TestCase class
# tells us that Rails generates tests based on the MiniTest Framework that
# comes preinstalled with Ruby.

# An assertion is simply a method call that tells the framework what we expect to be true
# The simplest asertion is the method assert(), which expects its argument to be true. 
# If it is, nothing happens.

# If the argument to assert() is false, the assertion fails. The framework will output a message
# and will stop executing the test method containing the failure. In our case, we expect that an
# empty Product model will not pass validation, so we can express that expectation by asserting
# that it isn't valid.

class ProductTest < ActiveSupport::TestCase

# The fixtures() directive loads the fixture data corresponding to the given model name into the
# corresponding DB table before each test method in the test case is run. The name of the
# fixture file determines the table that is loaded, so using :products will cause the products.yml
# fixture file to be used.

# Let's say that again another way. In the case of our ProductTest class, adding the
# fixtures directive means that the products table will be emptied out and then populated
# with the three rows defined in the fixture before each test method is run.

  fixtures :products

  test "product attributes must not be empty" do
  	product = Product.new
  	assert product.invalid?
  	assert product.errors[:title].any?
  	assert product.errors[:description].any?
  	assert product.errors[:price].any?
  	assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
  	product = Product.new(title: "My book title",
  		description: "yyy",
  		image_url: "zzz.jpg")
  	product.price = -1
  	assert product.invalid?
  	assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

  	product.price = 0
  	assert product.invalid?
  	assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

  	product.price = 1
  	assert product.valid?
  end

  def new_product(image_url)
  	Product.new(title: "My Book Title",
  		description: "yyy", 
  		price: 1,
  		image_url: image_url
  		)
  

  	test "image_url" do
	  	ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg 
  		http://a.b.c/x/y/z/fred.gif }
  		bad = %w{ fred.doc fred.gif/more fred.gif.more }

	  	ok.each do |name|
  			assert new_product(name).valid?, "#{name} should be valid"
  		end

  		bad.each do |name|
	  		assert new_product(name).invalid?, "#{name} shouldn't be valid"
	  	end
  	end
  end

  
  # The test assumes that the DB already includes a row for the Ruby book, it gets the title of that 
  # existing row using this:  products(:ruby).title

  test "product is not valid without a unique title" do
	product = Product.new(title: products(:ruby).title,
		description: "yyy",
		price: 1,
		image_url: "fred.gif")
	assert product.invalid?
	assert_equal ["has already been taken"], product.errors[:title]
  end

end