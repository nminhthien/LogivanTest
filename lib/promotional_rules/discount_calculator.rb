module LogivanTest
  class DiscountCalculator
    attr_reader :rules, :products, :original_total_price
    
    def initialize(rules = [], products = [], original_total_price = 0)
      # Re-order rules base on priority to make sure it work as our expectation
      @rules = rules.sort_by { |rule| rule.priority }
      @products = products
      @original_total_price = original_total_price
    end
    
    def calculate_total_discount
      total_discount = 0
      current_total = @original_total_price
      @rules.each do |rule|
        rule.products = @products
        rule.current_total = current_total
        total_discount += rule.calculate_discount
        # Re-calculate current total after discounted rule by rule with priority
        current_total = current_total - total_discount
      end
      total_discount
    end
  end
end