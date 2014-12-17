require 'spec_helper'

describe "validation/_message.html.erb", type: :view do

  it "displays errors and warnings correctly" do

    {
      :encoding => "Your CSV appears to be encoded in <code>iso-8859-1</code>. We recommend you use <code>UTF-8</code>.",
      :no_encoding => "The encoding of your CSV file is not being declared in the HTTP response.",
      :invalid_encoding => "Your CSV appears to be encoded in <code>iso-8859-1</code>, but invalid characters were found",
      :wrong_content_type => "Your CSV file is being delivered with an incorrect <code>Content-Type</code>",
      :no_content_type => "Your CSV file is being delivered without a <code>Content-Type</code> header",
      :nonrfc_line_breaks => "Your CSV appears to use <code>LF</code> line-breaks"
    }.each do |k, v|

      message = Csvlint::ErrorMessage.new(k, nil, nil, nil, nil, nil)
      validator = double("validator")
      validator.stub(:encoding) { "iso-8859-1" }
      validator.stub(:content_type) { "text/plain" }
      validator.stub(:extension) { ".csv" }
      validator.stub(:headers) { {"content-type" => "text/plain"} }
      validator.stub(:line_breaks) { "\n" }
      validator.stub(:schema) { nil }

      validator
      render :partial => "validation/message", :locals => { :message => message, :validator => validator }

      rendered.should include v
    end

  end

end

describe "validation/_validation.html.erb" do

  it "Should not revalidate" do
    mock_file("http://example.com/test.csv", 'csvs/valid.csv')
    Validation.create_validation('http://example.com/test.csv')
    validation = Validation.first

    validation.should_not_receive(:delay)
    render :partial => "validation/validation", :locals => { :validation => validation }
  end

end
