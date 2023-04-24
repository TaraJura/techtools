# frozen_string_literal: true

class IsdocTool
  def initialize(invoice)
    @invoice = invoice
    @file_key = @invoice.file.key
    @isdoc = @invoice.file.service.path_for(@file_key)
  end

  def payment_method_to_string(payment_method)
    case payment_method
    when '10'
      'Platba v hotovosti'
    when '20'
      'Platba šekem'
    when '31'
      'Credit transfer'
    when '42'
      'Převod na účet'
    when '48'
      'Platba kartou'
    when '49'
      'Direct debit'
    when '50'
      'Platba dobírkou'
    when '97'
      'Zaúčtování mezi partnery'
    else
      'Neznámá metoda platby'
    end
  end

  def convert_to_hash
    doc = Nokogiri::XML.parse File.open(@isdoc)
    doc.remove_namespaces!

    ############################################################################################################# SUPPLIER

    supplier_name = doc&.at('//Invoice//Party')&.at('PartyName')&.inner_text
    supplier_adress = doc&.at('//Invoice//PostalAddress')&.at('StreetName')&.inner_text
    supplier_building_number = doc&.at('//Invoice//PostalAddress')&.at('BuildingNumber')&.inner_text
    supplier_full_adress = supplier_adress + ' ' + supplier_building_number
    supplier_city = doc&.at('//Invoice//PostalAddress')&.at('CityName')&.inner_text
    supplier_country = doc&.at('//Invoice//PostalAddress')&.at('Country')&.at('IdentificationCode')&.inner_text
    supplier_ico = doc&.at('//Invoice//Party')&.at('PartyIdentification')&.at('ID')&.inner_text
    supplier_dic = doc&.at('//Invoice//Party')&.at('PartyTaxScheme')&.at('CompanyID')&.inner_text
    supplier_contact = doc&.at('//Invoice//Contact')&.at('Name')&.inner_text
    supplier_phone = doc&.at('//Invoice//Contact')&.at('Telephone')&.inner_text
    supplier_email = doc&.at('//Invoice//Contact')&.at('ElectronicMail')&.inner_text

    ############################################################################################################# SUBSCRIBER

    subscriber_name = doc&.at('//Invoice//AccountingCustomerParty')&.at('Party')&.at('PartyName')&.inner_text
    subscriber_adress = doc&.at('//Invoice//AccountingCustomerParty')&.at('Party')&.at('PostalAddress')&.at('StreetName')&.inner_text
    subscriber_building_number = doc&.at('//Invoice//AccountingCustomerParty')&.at('Party')&.at('PostalAddress')&.at('BuildingNumber')&.inner_text
    subscriber_full_adress = subscriber_adress + ' ' + subscriber_building_number
    subscriber_city = doc&.at('//Invoice//AccountingCustomerParty')&.at('Party')&.at('PostalAddress')&.at('CityName')&.inner_text
    subscriber_country = doc&.at('//Invoice//AccountingCustomerParty')&.at('Party')&.at('PostalAddress')&.at('Country')&.at('IdentificationCode')&.inner_text
    subscriber_ico = doc&.at('//Invoice//AccountingCustomerParty')&.at('Party')&.at('PartyIdentification')&.at('ID')&.inner_text
    subscriber_dic = doc&.at('//Invoice//AccountingCustomerParty')&.at('Party')&.at('PartyTaxScheme')&.at('CompanyID')&.inner_text
    subscriber_contact = doc&.at('//Invoice//AccountingCustomerParty')&.at('Party')&.at('Contact')&.at('Name')&.inner_text
    subscriber_phone = doc&.at('//Invoice//AccountingCustomerParty')&.at('Party')&.at('Contact')&.at('Telephone')&.inner_text
    subscriber_email = doc&.at('//Invoice//AccountingCustomerParty')&.at('Party')&.at('Contact')&.at('ElectronicMail')&.inner_text

    ############################################################################################################# INVOICE DATA

    invoice_id = doc&.at('//Invoice//ID')&.inner_text
    invoice_uuid = doc&.at('//Invoice//UUID')&.inner_text
    invoice_issuing_system = doc&.at('//Invoice//IssuingSystem')&.inner_text
    invoice_issue_date = doc&.at('//Invoice//IssueDate')&.inner_text
    invoice_tax_point_date = doc&.at('//Invoice//TaxPointDate')&.inner_text
    invoice_vat_applicable = doc&.at('//Invoice//VATApplicable')&.inner_text
    invoice_electronic_possibility_agreement_reference = doc&.at('//Invoice//ElectronicPossibilityAgreementReference')&.inner_text
    invoice_note = doc&.at('//Invoice//Note')&.inner_text
    invoice_local_currency_code = doc&.at('//Invoice//LocalCurrencyCode')&.inner_text
    invoice_curr_rate = doc&.at('//Invoice//CurrRate')&.inner_text
    invoice_ref_curr_rate = doc&.at('//Invoice//RefCurrRate')&.inner_text

    ############################################################################################################# PAYMENT DATA

    payment_method = payment_method_to_string(doc&.at('//Invoice//PaymentMeans')&.at('PaymentMeansCode')&.inner_text.to_s)
    payment_paid_amount = doc&.at('//Invoice//PaymentMeans')&.at('Payment')&.at('PaidAmount')&.inner_text
    payment_due_date = doc&.at('//Invoice//PaymentMeans')&.at('Payment')&.at('Details')&.at('PaymentDueDate')&.inner_text
    payment_id = doc&.at('//Invoice//PaymentMeans')&.at('Payment')&.at('Details')&.at('ID')&.inner_text
    payment_bank_code = doc&.at('//Invoice//PaymentMeans')&.at('Payment')&.at('Details')&.at('BankCode')&.inner_text
    payment_name = doc&.at('//Invoice//PaymentMeans')&.at('Payment')&.at('Details')&.at('Name')&.inner_text
    payment_iban = doc&.at('//Invoice//PaymentMeans')&.at('Payment')&.at('Details')&.at('IBAN')&.inner_text
    payment_bic = doc&.at('//Invoice//PaymentMeans')&.at('Payment')&.at('Details')&.at('BIC')&.inner_text
    payment_variable_symbol = doc&.at('//Invoice//PaymentMeans')&.at('Payment')&.at('Details')&.at('VariableSymbol')&.inner_text
    payment_constant_symbol = doc&.at('//Invoice//PaymentMeans')&.at('Payment')&.at('Details')&.at('ConstantSymbol')&.inner_text
    payment_specific_symbol = doc&.at('//Invoice//PaymentMeans')&.at('Payment')&.at('Details')&.at('SpecificSymbol')&.inner_text

    ############################################################################################################# INVOICE LINES

    invoice_lines = doc&.at('//Invoice//InvoiceLines')&.children&.select { |x| x.name == 'InvoiceLine' }&.map do |invoice_line|
      item_description =  invoice_line.at('Item')&.at('Description')&.inner_text
      item_catalogue_item_identification = invoice_line.at('Item')&.at('CatalogueItemIdentification')&.at('ID')&.inner_text
      item_sellers_item_identification = invoice_line.at('Item')&.at('SellersItemIdentification')&.at('ID')&.inner_text
      item_secondary_sellers_item_identification = invoice_line.at('Item')&.at('SecondarySellersItemIdentification')&.at('ID')&.inner_text
      item_tertiary_sellers_item_identification = invoice_line.at('Item')&.at('TertiarySellersItemIdentification')&.at('ID')&.inner_text
      item_buyers_item_identification = invoice_line.at('Item')&.at('BuyersItemIdentification')&.at('ID')&.inner_text
      percent = invoice_line&.at('ClassifiedTaxCategory')&.at('Percent')&.inner_text
      vat_calculation_method = invoice_line&.at('ClassifiedTaxCategory')&.at('VATCalculationMethod')&.inner_text
      vat_applicable = invoice_line&.at('ClassifiedTaxCategory')&.at('VATApplicable')&.inner_text

      {
        id: invoice_line.at('ID')&.inner_text,
        invoiced_quantity: invoice_line.at('InvoicedQuantity')&.inner_text,
        line_extension_amount: invoice_line.at('LineExtensionAmount')&.inner_text,
        line_extension_amount_tax_inclusive: invoice_line.at('LineExtensionAmountTaxInclusive')&.inner_text,
        line_extension_tax_amount: invoice_line.at('LineExtensionTaxAmount')&.inner_text,
        unit_price: invoice_line.at('UnitPrice')&.inner_text,
        unit_price_tax_inclusive: invoice_line.at('UnitPriceTaxInclusive')&.inner_text,
        classified_tax_category: { percent:, vat_calculation_method:, vat_applicable: },
        note: invoice_line.at('Note')&.inner_text,
        vat_note: invoice_line.at('VATNote')&.inner_text,
        item: { item_description:, item_catalogue_item_identification:, item_sellers_item_identification:, item_secondary_sellers_item_identification:, item_tertiary_sellers_item_identification:, item_buyers_item_identification: }
      }
    end

    ############################################################################################################# TaxTotal

    tax_sub_total_final = doc&.at('//Invoice//TaxTotal')&.children&.select { |x| x.name == 'TaxSubTotal' }&.map do |tax_sub_total|
      percent = tax_sub_total.at('TaxCategory')&.at('Percent')&.inner_text
      vat_applicable = tax_sub_total.at('TaxCategory')&.at('VATApplicable')&.inner_text
      local_reverse_charge_flag = tax_sub_total.at('TaxCategory')&.at('LocalReverseChargeFlag')&.inner_text

      {
        taxable_amount: tax_sub_total.at('TaxableAmount')&.inner_text,
        tax_amount: tax_sub_total.at('TaxAmount')&.inner_text,
        tax_inclusive_amount: tax_sub_total.at('TaxInclusiveAmount')&.inner_text,
        already_claimed_taxable_amount: tax_sub_total.at('AlreadyClaimedTaxableAmount')&.inner_text,
        already_claimed_tax_amount: tax_sub_total.at('AlreadyClaimedTaxAmount')&.inner_text,
        already_claimed_tax_inclusive_amount: tax_sub_total.at('AlreadyClaimedTaxInclusiveAmount')&.inner_text,
        difference_taxable_amount: tax_sub_total.at('DifferenceTaxableAmount')&.inner_text,
        difference_tax_amount: tax_sub_total.at('DifferenceTaxAmount')&.inner_text,
        difference_tax_inclusive_amount: tax_sub_total.at('DifferenceTaxInclusiveAmount')&.inner_text,
        tax_category: { percent:, vat_applicable:, local_reverse_charge_flag: }
      }
    end

    tax_amount = doc&.at('//Invoice//TaxTotal')&.at('TaxAmount')&.inner_text

    ############################################################################################################# LegalMonetaryTotal

    tax_exclusive_amount = doc&.at('//Invoice//LegalMonetaryTotal')&.at('TaxExclusiveAmount')&.inner_text
    tax_inclusive_amount = doc&.at('//Invoice//LegalMonetaryTotal')&.at('TaxInclusiveAmount')&.inner_text
    already_claimed_tax_exclusive_amount = doc&.at('//Invoice//LegalMonetaryTotal')&.at('AlreadyClaimedTaxExclusiveAmount')&.inner_text
    already_claimed_tax_inclusive_amount = doc&.at('//Invoice//LegalMonetaryTotal')&.at('AlreadyClaimedTaxInclusiveAmount')&.inner_text
    difference_tax_exclusive_amount = doc&.at('//Invoice//LegalMonetaryTotal')&.at('DifferenceTaxExclusiveAmount')&.inner_text
    difference_tax_inclusive_amount = doc&.at('//Invoice//LegalMonetaryTotal')&.at('DifferenceTaxInclusiveAmount')&.inner_text
    payable_rounding_amount = doc&.at('//Invoice//LegalMonetaryTotal')&.at('PayableRoundingAmount')&.inner_text
    paid_deposits_amount = doc&.at('//Invoice//LegalMonetaryTotal')&.at('PaidDepositsAmount')&.inner_text
    payable_amount = doc&.at('//Invoice//LegalMonetaryTotal')&.at('PayableAmount')&.inner_text

    ############################################################################################################# FINAL HASH

    { supplier: { supplier_name:, supplier_full_adress:, supplier_city:, supplier_country:, supplier_ico:, supplier_dic:, supplier_contact:, supplier_phone:, supplier_email: },
      subscriber: { subscriber_name:, subscriber_full_adress:, subscriber_city:, subscriber_country:, subscriber_ico:, subscriber_dic:, subscriber_contact:, subscriber_phone:, subscriber_email: },
      invoice: { invoice_id:, invoice_uuid:, invoice_issuing_system:, invoice_issue_date:, invoice_tax_point_date:, invoice_vat_applicable:, invoice_electronic_possibility_agreement_reference:, invoice_note:,
                 invoice_local_currency_code:,
                 invoice_curr_rate:, invoice_ref_curr_rate: },
      payment: { payment_method:, payment_paid_amount:, payment_due_date:, payment_id:, payment_bank_code:, payment_name:, payment_iban:, payment_bic:, payment_variable_symbol:, payment_constant_symbol:, payment_specific_symbol: },
      invoice_lines:,
      tax_total: { tax_sub_total_final:, tax_amount: },
      legal_monetary_total: { tax_exclusive_amount:, tax_inclusive_amount:, already_claimed_tax_exclusive_amount:, already_claimed_tax_inclusive_amount:, difference_tax_exclusive_amount:, difference_tax_inclusive_amount:,
                              payable_rounding_amount:, paid_deposits_amount:, payable_amount: } }
  end
end
