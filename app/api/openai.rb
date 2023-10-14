# frozen_string_literal: true

class Openai
  def initialize
    api_key = Rails.application.credentials.openai[:"api-key"]
    @client = OpenAI::Client.new(access_token: api_key)
    @model = 'gpt-3.5-turbo'
  end

  def question(question)
    response = @client.chat(
      parameters: {
        model: @model,
        messages: [{ role: 'user', content: question }],
        temperature: 0.7
      }
    )
    if response['choices'].nil?
      'No response from OpenAI'
    else
      response['choices'].first['message']['content']
    end
  end
end
