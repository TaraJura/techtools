require 'rails_helper'

RSpec.describe "invoices/show", type: :view do
  before(:each) do
    assign(:invoice, Invoice.create!(
      name: "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
