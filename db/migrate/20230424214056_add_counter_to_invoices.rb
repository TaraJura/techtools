class AddCounterToInvoices < ActiveRecord::Migration[7.0]
  def change
    add_column :invoices, :converted_to_png, :boolean
    add_column :invoices, :converted_to_pdf, :boolean
  end
end
