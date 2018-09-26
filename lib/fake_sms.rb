module FakeSms
  Message = Struct.new(:message1, :message) #TODO Cambié :message a :message1 Verificar el error de duplicate :message
  @messages = []

  def self.send_sms(number:, message:)
    @messages << Message.new(number, message)
  end

  def self.messages
    @messages
  end
end