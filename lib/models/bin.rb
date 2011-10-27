class Bin
  include DataMapper::Resource
  property :id, Serial
  property :url, String

  has n, :items

  def random_url
    Digest::SHA1.hexdigest(Time.now.to_f.to_s + id.to_s)[0..7]
  end
end
