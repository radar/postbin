class Item
  include DataMapper::Resource
  property :id, Serial
  property :params, Text
  
  belongs_to :bin
  
  def parsed_params
    begin
      JSON.parse(params)
    rescue JSON::ParserError
      params
    end
  end
  
end
