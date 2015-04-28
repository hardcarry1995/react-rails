require 'test_helper'
require 'fileutils'

class ReactTest < ActionDispatch::IntegrationTest
  test 'asset pipeline should deliver drop-in react file replacement' do
    app_react_file_path = File.expand_path("../dummy/vendor/assets/javascripts/react.js",  __FILE__)

    react_file_token = "'test_confirmation_token_react_content_non_production';\n";
    File.write(app_react_file_path, react_file_token)

    get '/assets/react.js'

    File.unlink(app_react_file_path)
    FileUtils.rm_r CACHE_PATH if CACHE_PATH.exist?

    assert_response :success
    assert_equal react_file_token, @response.body
  end
end
