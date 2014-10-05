class UserFromAuth
  attr_reader :auth

  def initialize(auth)
    @auth = auth
  end

  def build
    User.new do |u|
      u.nickname = nickname
      u.email = email
      u.name = name
      u.image_url = image_url
      u.remote_uid = remote_uid
      u.provider = provider
    end
  end

  def find
    User.where(remote_uid: remote_uid, provider: provider).first
  end

  def find_or_build
    find || build
  end

  private

  def remote_uid
    auth.fetch("uid")
  end

  def provider
    auth.fetch("provider")
  end

  def info
    auth.fetch("info")
  end

  def nickname
    info.fetch("nickname")
  end

  def email
    info.fetch("email")
  end

  def name
    info.fetch("name")
  end

  def image_url
    info.fetch("image")
  end
end
