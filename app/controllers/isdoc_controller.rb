# frozen_string_literal: true

class IsdocController < ApplicationController
  def show
    invoice = Invoice.find(params[:id])
    if invoice.file.filename.to_s.split('.').last == 'isdoc'
      invoice_data = IsdocTool.new(invoice).convert_to_hash 
      @supplier = invoice_data[:supplier]
      @subscriber = invoice_data[:subscriber]
      @invoice = invoice_data[:invoice]
      @payment = invoice_data[:payment]
      @invoice_lines = invoice_data[:invoice_lines]
      @tax_total = invoice_data[:tax_total]
      @legal_monetary_total = invoice_data[:legal_monetary_total]
      render layout: 'minimal'
    else
      redirect_to root_path, notice: 'Tento súbor nie je ISDOC'
    end
  end
end
