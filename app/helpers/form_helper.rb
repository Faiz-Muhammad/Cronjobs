module FormHelper
  def setup_user()
    current_user.pages ||= Page.new
    current_user
  end
end
