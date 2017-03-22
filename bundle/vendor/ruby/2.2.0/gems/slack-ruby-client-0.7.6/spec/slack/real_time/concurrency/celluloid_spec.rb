require 'spec_helper'

begin
  RSpec.describe Slack::RealTime::Concurrency::Celluloid::Socket do
    context 'with url' do
      let(:url) { 'wss://echo.websocket.org/websocket/xyz' }
      let(:logger) { ::Logger.new(STDOUT) }
      subject(:socket) { described_class.new(url, ping: 42, logger: logger) }
      let(:driver) { WebSocket::Driver::Client }
      let(:ws) { double(driver) }

      describe '#initialize' do
        it 'sets url' do
          expect(socket.url).to eq url
        end
      end

      describe '#connect!' do
        pending 'connects'
        pending 'pings every 30s'
      end

      describe '#disconnect!' do
        it 'closes and nils the websocket' do
          socket.instance_variable_set('@driver', ws)
          expect(ws).to receive(:close)
          socket.disconnect!
        end
      end

      pending 'send_data'
    end
  end
rescue LoadError
end
