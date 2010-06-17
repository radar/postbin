Given /^there is a bin called "([^\"]*)"$/ do |url|
  @bin = Bin.create(:url => @url)
end

When /^there is JSON data posted to this bin$/ do
  post "/#{@url}", :body => "Text"
end

Then /^the bin should have an item with this data$/ do
  @bin.items.first.params.should eql({"hey" => "ya"})
end
