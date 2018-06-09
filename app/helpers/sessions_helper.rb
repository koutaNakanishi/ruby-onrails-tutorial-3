module SessionsHelper

	def log_in(user)#渡されたユーザでログインする
		session[:user_id]=user.id#一次cookiesに暗号化したユーザIDが生成される
	end

	def current_user #今のユーザ名を表示するやつ
		@current_user ||= User.find_by(id:session[:user_id])
		#@current_user= @current_user ||(otherwise) User.find_by(id: session[:user_id])
	end

	def logged_in?
		!current_user.nil?
	end

	def log_out
		session.delete(:user_id)
		@current_user=nil
	end
end
