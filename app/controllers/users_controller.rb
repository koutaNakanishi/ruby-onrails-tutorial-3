class UsersController < ApplicationController
  def new
		@user=User.new
	#	debugger
  end
	
	def create
	#	@user=User.new(params[:user])丸々paramsのhashを渡すのは良くない
		@user=User.new(user_params)
		if@user.save
			log_in @user
			flash[:success]="Welcome to the Sample App! 登録完了"
			#初めは登録完了ページを出したい
			redirect_to @user
			#作成されたゆーざぺーじにとぶ /users/3など
		else 
			render 'new'
		end
	end

	def show
		@user=User.find(params[:id])

	end

	def edit
		@user=User.find(params[:id])
	end

	def update

		@user=User.find(params[:id])
		if @user.update_attributes(user_params)#user_paramsを引数に更新出来たら
			flash[:success]="Profile updated"
			redirect_to @user
		else 
			render 'edit'
		end
	end


	private#ネットワーク経由で実行できない（攻撃される危険性が少ない？）ヘルパー
		def user_params

			params.require(:user).permit(:name,:email,:password,:password_confirmation)
		end 
		
end
