module WelcomeHelper
  def landing?
    request.fullpath == "/"
  end

  def path?(url)
    request.fullpath.include? url
  end
end
