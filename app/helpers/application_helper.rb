module ApplicationHelper
  def go_back
    if request.referer
      URI(request.referer).path
    end
  end
end
