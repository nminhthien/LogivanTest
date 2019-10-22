module LogivanTest
  class Error
    TOTAL_PRICE_FROM_MUST_BE_POSITIVE_NUMBER = 'Error: Total price from have to be positive number'
    DISCOUNT_PERCENT_MUST_BE_POSITIVE_NUMBER = 'Error: Discount percent have to be positive number'
    PRODUCT_CODE_MUST_PRESENT = 'Error: The product code have to be provided'
    NUMBER_PRODUCT_MUST_BE_POSITIVE_NUMBER = 'Error: Number product from have to be positive number'
    DISCOUNT_PRICE_MUST_BE_POSITIVE_NUMBER = 'Error: Discount price have to be positive number'
    DISCOUNT_PRICE_MUST_BE_SMALLER_NORMAL_PRICE = 'Error: The discounted price have to be smaller than normal price'
    PARAMS_MUST_BE_HASH = 'Error: Input params have to be a hash'
    INVALID_PROMOTION_RULE = 'Error: Invalid promotional rule!'
    CANNOT_APPLY_MULTI_RULES_FOR_A_PRODUCT_CODE = 'Error: Cannot apply multiple rules for a product code'
    CANNOT_APPLY_MULTI_RULES_FOR_TOTAL_PRICE = 'Error: Cannot apply multiple rules for discount percent base on total price'
    INVALID_PRODUCT = 'Error: Invalid Product!'
  end
end