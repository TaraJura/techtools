# frozen_string_literal: true

class PdfPreviewChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'pdf_preview_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
