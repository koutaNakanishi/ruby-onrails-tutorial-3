class User < ApplicationRecord

	before_save{self.email.downcase!}
	validates:name,presence:true,length:{maximum:50}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates:email,presence:true,length:{maximum:255},format:{with: VALID_EMAIL_REGEX},
	uniqueness:{case_sensitive:false}

	
	# 関数password_digestにハッシュ化パスを保存できる
	#passwordとpassword_confirmationがつかえるようになる
	#authenticate 引数とパスワードが一致するとUserオブジェクトを、間違ってるとfalseを変える関数が使える
	has_secure_password
	validates :password, presence:true ,length: {minimum:6}
	

end
