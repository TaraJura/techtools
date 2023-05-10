# frozen_string_literal: true

require 'zip'

class IsdocxExtractor
  def initialize(invoice)
    file_key = invoice.file.key
    isdocx = invoice.file.service.path_for(file_key)

    extract_dir = Rails.public_path.join('invoice_previews', 'pdf')
    FileUtils.mkdir_p(extract_dir) unless File.directory?(extract_dir)

    extract_path = extract_dir.join("#{invoice.id}.pdf")
    @output_path = extract_path.relative_path_from(Rails.public_path)

    # Check if the file already exists
    if File.file?(extract_path)
      # The file already exists, so just return the path to the existing file
      return
    end

    # create a Zip::File object with the .isdocx file
    Zip::File.open(isdocx) do |zip_file|
      # iterate over each entry in the zip file
      zip_file.each do |entry|
        # if the entry is a PDF file, extract it to the specified path
        if entry.name.end_with?('.pdf')
          entry.extract(extract_path)
          return
        end
      end
    end

    # If we reach this point, it means the PDF file was not found in the .isdocx archive
    raise "PDF file not found in #{isdocx}"
  end

  def path
    @output_path.to_s
  end
end
