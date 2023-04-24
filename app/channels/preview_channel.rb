# frozen_string_literal: true

class PreviewChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'preview_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
