require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
	def setup	
		@user=user(:michael)
	end

	test "micropost interface" do
		log_in_as(@user)
		get root_path
		assert_select 'div.pagination'
		
		assert_no_difference 'Micropost.count' do
			post microposts_path, params: {micropost: {content: "" }}#無効な送信
	end
	
	assert_select 'div#error_explanation'
	content="This micropost really ties the room together"

	assert_difference 'Micropost.count',1 do
		post microposts_path, params: {micropost: {content: content}}
	end
	assert_redirected_to root_url #投稿した後は、ルートにリダイレクト
	follow_redirect! 
	assert_match content, response.body
	#投稿を削除

	end

end
