require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
	def setup	
		@user=users(:michael)
	end

	test "micropost interface" do
		post login_path,params:{session: {email: @user.email,password:'password'} }
		log_in_as(@user)
		get root_path
#虫！		assert_select 'div.pagination'
		
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
	assert_select 'a' , text: 'delete'
	first_micropost=@user.microposts.paginate(page: 1).first

	assert_difference 'Micropost.count',-1 do
		delete micropost_path(first_micropost)
	end
	
	get user_path(users(:archer))
#		debugger
		assert_select 'a', text: 'delete', count: 0

	end

end
