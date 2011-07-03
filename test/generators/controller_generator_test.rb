require 'test_helper'
require 'generators/generators_test_helper'
require "generators/backbone/controller/controller_generator"

class ControllerGeneratorTest < Rails::Generators::TestCase
  include GeneratorsTestHelper
  tests Backbone::Generators::ControllerGenerator
  
  test "simple controller with two actions" do
    run_generator ["Posts", "index", "edit"]
    
    assert_file "#{backbone_path}/controllers/posts_controller.js.coffee"
    
    %W{index edit}.each do |action|
      assert_file "#{backbone_path}/views/posts/#{action}_view.js.coffee"
      assert_file "#{backbone_path}/templates/posts/#{action}.jst.ejs"
    end
  end
  
  test "raises an error when an action is a javascript reserved word" do
    content = capture(:stderr){ run_generator ["Posts", "new"] }
    assert_equal "The name 'new' is reserved by javascript Please choose an alternative action name and run this generator again.\n", content
  end
  
end