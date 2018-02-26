class Helper 
  
  def self.current_user
    if session[:id]
      @current_user ||= User.find(session[:id])
    end
  end 
  
  def self.logged_in?
    !!current_user
  end
  
end