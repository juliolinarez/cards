module HomeHelper
  def user_greeting
    if user_signed_in?
      first_name = current_user.email.split('@').first.split('.').first.capitalize
      "Welcome back, #{first_name}!"
    else
      "Welcome to Proxyfield!"
    end
  end

  def feature_card(title, description)
    content_tag(:div, class: "bg-white bg-opacity-10 backdrop-blur-lg rounded-xl p-6 border border-white border-opacity-20") do
      concat(content_tag(:div, "", class: "w-12 h-12 bg-purple-500 rounded-lg flex items-center justify-center mb-4"))
      concat(content_tag(:h3, title, class: "text-xl font-semibold text-white mb-2"))
      concat(content_tag(:p, description, class: "text-purple-200 text-sm"))
    end
  end
end
