require 'rails_helper'

RSpec.describe "invoices/edit", type: :view do
  let(:invoice) {
    Invoice.create!(
      name: "MyString"
    )
  }

  before(:each) do
    assign(:invoice, invoice)
  end

  it "renders the edit invoice form" do
    render

    assert_select "form[action=?][method=?]", invoice_path(invoice), "post" do

      assert_select "input[name=?]", "invoice[name]"
    end
  end
end
