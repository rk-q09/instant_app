module ApplicationHelper

  def document_title
    if @title.present?
      "#{@title} - InstantApp"
    else
      "InstantApp"
    end
  end

  #渡されたユーザーがログイン済みユーザーであればtrueを返す
  def current_user?(user)
    user == current_user
  end
end
