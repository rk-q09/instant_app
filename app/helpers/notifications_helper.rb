module NotificationsHelper
  def notification_form(notification)
    @visitor = notification.visitor

    case notification.action
      when "follow" then
        tag.a(@visitor.user_name, href:user_path(@visitor)) + "があなたをフォローしました"
      when "like" then
        tag.a(@visitor.user_name, href:user_path(@visitor)) + "が" +
          tag.a('あなたの投稿', href: post_path(notification.post_id)) + "にいいね！しました"
      when "comment" then
        tag.a(@visitor.user_name, href:user_path(@visitor)) + "が" +
          tag.a('あなたの投稿', href: post_path(notification.post_id)) + "にコメントしました"
    end
  end
end
