# frozen_string_literal: true

class IsdocToPdf
  def initialize(invoice_number)
    session = Net::SSH.start('localhost', 'deploy') if Rails.env.production?
    local_url = 'http://localhost:3001' if Rails.env.development?
    local_url = 'https://porfa.weleda.space' if Rails.env.production?
    img_path = Rails.root.to_s + '/public/invoice_previews/png/' + invoice_number.to_s + '.png'
    pdf_path = Rails.root.to_s + '/public/invoice_previews/pdf/' + invoice_number.to_s + '.pdf'

    browser = Watir::Browser.new :firefox, headless: true
    browser.goto(local_url + '/isdoc/' + invoice_number.to_s)
    browser.window.resize_to(1606, 1314)
    element = browser.element(css: '.row.justify-content-center')
    location = element.location
    size = element.size
    browser.screenshot.save(img_path)
    image = MiniMagick::Image.open(img_path)
    image.crop("#{size[:width]}x#{size[:height]}+#{location[:x]}+#{location[:y]}")
    image.write(img_path)

    MiniMagick::Tool::Convert.new do |convert|
      convert << img_path
      convert << pdf_path
    end

    Invoice.find_by(id: invoice_number).update(path_to_isdoc_preview: '/invoice_previews/pdf/' + invoice_number.to_s + '.pdf')
    browser.close
    session.close if Rails.env.production?
  end
end
