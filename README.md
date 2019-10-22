# LOGIVAN - Project for the Ruby on Rails Developer position

This is the LOGIVAN Ruby on Rails Developer project. It is a checkout system that support offering promotions to customers   

Here are some main classes in this project:

	PromotionalRule: Define common properties of rules
	DiscountPercentOnTotalPricePromotionalRule: Define rule for discount percent base on total price. This class extend from PromotionalRule
	DiscountPriceOnSpecificProductPromotionalRule: Define rule for discount price on a specific product. This class extend from PromotionalRule
	DiscountCalculator: Define how the rules will be applied such as: priority and calculate total amount will be discounted
	Product: Define properties of products
	Checkout: Define checkout flow with and without promotions and calculate to get the final price that customers need to pay
	Error: Define error messages

This project using Rspec without Rails.

## Getting started

To run this demo, it is better with Ruby 2.4.2 or higher.

To install the gems by running:

    bundle install

## How to run the test suite

To test that it works we can use 'RSpec' to see it working:

    bundle exec rspec

The result should be like this:

	LogivanTest::Checkout
      Checkout without promotion
        Does not have any promotion rule
        Have promotional rules but does not match condition to apply
      Only one promotional rule is applied
        Discount percent on total price
        Discount price on a specific product
        Discount price on many specific products
      Multiple promotional rules are applied
        Discount price on a specific product and percent on total price
      Checkout with exception
        The discount price is greater than normal price
        Checkout scan with invalid product
        Checkout scan with no product
        Checkout with invalid rules
        Checkout with multiple rules for a product
        Checkout with multiple rules for discount percent base on total price
    
    LogivanTest::Product
      Init product successfully with default value
      Init product successfully with value
      Init product unsuccessfully with exception
    
    LogivanTest::DiscountCalculator
      Init discount calculator successfully with default value
      Init discount calculator successfully
    
    LogivanTest::DiscountPercentOnTotalPricePromotionalRule
      Success on initialization
        Create rule successfully
      Error on initialization
        Invalid total price from with value is nil
        Invalid total price from with value is negative number
        Invalid total price from with value is not a number
        Invalid total price from with value is zero
        Invalid discount percent with value is nil
        Invalid discount percent with value is negative number
        Invalid discount percent with value is not a number
        Invalid discount percent with value is zero
    
    LogivanTest::DiscountPriceOnSpecificProductPromotionalRule
      Success on initialization
        Create rule successfully
      Error on initialization
        Invalid product code
        Invalid number product from with value is nil
        Invalid number product from with value is negative number
        Invalid number product from with value is not a number
        Invalid discount price with value is nil
        Invalid discount price with value is negative number
        Invalid discount price with value is not a number
    
    LogivanTest::PromotionalRule
      Create promotional rule successfully
    
    Finished in 0.02045 seconds (files took 0.22685 seconds to load)
    35 examples, 0 failures

## Test data
Test data for some main cases of checkout is defined in:
	
	spec/fixtures.yml

## License: MIT
