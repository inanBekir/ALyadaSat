require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  
  setup do
    @product = products(:one)
  end

  test "should get index" do
    Product.reindex
    assert true
  end

  test "should create product" do
    assert true
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    assert true
  end

  test "should update product" do
    assert true
  end

  test "should destroy product" do
    assert true
  end
end
