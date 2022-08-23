RSpec.describe Pwush::Client do
  subject(:client) { described_class.new(options) }

  let(:host_url) { 'https://cp.pushwoosh.com/json/1.3' }
  let(:options) {
    {
      auth: 'authtoken1',
      app: '000000-00000'
    }
  }

  let(:headers) {
    {
      'Connection' => 'close',
      'Content-Type' => 'application/json; charset=UTF-8',
      'Host' => 'cp.pushwoosh.com',
      'User-Agent' => 'http.rb/3.3.0'
    }
  }

  let(:response_headers) {
    {
      'Content-Type' => 'application/json; charset=UTF-8'
    }
  }

  describe '#push' do
    let(:action_url) { host_url + '/createMessage' }

    let(:fixture) { load_yaml('create_message') }
    let(:request_body) { fixture['in'].to_json }
    let(:ok_response) { fixture['out']['ok'].to_json }
    let(:fail_response) { fixture['out']['fail'].to_json }

    context 'when timeout' do
      let(:message) { Pwush::Message.new(content: 'hello world') }

      it 'returns wrapped exception' do
        stub_request(:post, action_url).to_timeout

        response = client.push(message)

        expect(response).to be_failure
        expect(response.failure).to be_a(HTTP::TimeoutError)
      end
    end

    context 'full message with all attributes available' do
      let(:message) {
        Pwush::Message.new(
          content: {
              en: 'Hello',
              es: 'Hola',
              ru: 'Zdarova'
            },
          send_date: '2018-04-20 13:35',
          ignore_user_timezone: true,
          timezone: 'Europe/Moscow',
          campaign: 'Specs',
          page_id: 1,
          rich_page_id: 42,
          rich_media: 'XXXX-XXXX',
          remote_page: 'http://myremoteurl.com',
          link: 'http://google.com',
          minimize_link: 0,
          data: { a: 1, b: 2},
          platforms: [1, 2, 3, 5],
          preset: 'Q1A2Z-6X8SW',
          send_rate: 500,
          devices: ['68753A44-4D6F-1226-9C60-0050E4C00067'],
          users: ['uid12', 'uid13'],
          filter: 'FILTER_NAME',
          dynamic_content_placeholders: { firstname: 'John', age: 38 },
          conditions: ['TAG_CONDITION1', 'TAG_CONDITION2'],
          ios_badges: 13,
          ios_sound: 'sound.wav',
          ios_ttl: 3600,
          ios_silent: 1,
          ios_category_id: 38,
          ios_root_params: {
            aps: {
              :'content-available' => 1,
              :'mutable-content' => 1
            }
          },
          apns_trim_content: 0,
          ios_title: 'Title',
          ios_subtitle: 'SubTitle',
          android_root_params: { p: 314 },
          android_sound: 'sound.wav',
          android_header: 'Head',
          android_icon: 'icon',
          android_custom_icon: 'http://example.com/image.png',
          android_banner: 'http://example.com/banner.png',
          android_badges: 3,
          android_gcm_ttl: 3500,
          android_vibration: true,
          android_led: '#55A100',
          android_priority: -1,
          android_ibc: '#FFFFAA',
          android_silent: 0,
          adm_root_params: { k: 'value' },
          adm_sound: 'push.mp3',
          adm_header: 'Head',
          adm_icon: 'icon',
          adm_custom_icon: 'http://example.com/image.png',
          adm_banner: 'http://example.com/banner.png',
          adm_ttl: 1100,
          adm_priority: -1,
          wp_type: 'Tile',
          wp_background: '/Resources/Red.jpg',
          wp_backbackground: '/Resources/Green.jpg',
          wp_backtitle: 'back title',
          wp_backcontent: 'back content',
          wp_count: 3,
          blackberry_header: 'header',
          mac_badges: 3,
          mac_sound: 'sound.caf',
          mac_root_params: { :'content-available' => 1 },
          mac_ttl: 2300,
          wns_content: {
            en: 'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz48YmFkZ2UgdmFsdWU9ImF2YWlsYWJsZSIvPg==',
            de: 'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz48YmFkZ2UgdmFsdWU9Im5ld01lc3NhZ2UiLz4='
          },
          wns_type: 'Badge',
          wns_tag: 'myTag',
          wns_cache: 1,
          wns_ttl: 600,
          safari_title: 'Title',
          safari_action: 'Click here',
          safari_url_args: ['firstArgument', 'secondArgument'],
          safari_ttl: 3600,
          chrome_title: 'Chrome!',
          chrome_icon: 'http://example.com/icon.png',
          chrome_gcm_ttl: 3600,
          chrome_duration: 20,
          chrome_image: 'http://example.com/large_image.png',
          chrome_button_text1: 'text1',
          chrome_button_url1: 'http://example.com/url1',
          chrome_button_text2: 'text2',
          chrome_button_url2: 'http://example.com/url2',
          firefox_title: 'FF Title',
          firefox_icon: 'http://example.com/fficon.png'
        )
      }

      it 'returns successful result' do
        stub_request(:post, action_url)
          .with(headers: headers, body: request_body)
          .to_return(headers: response_headers, body: ok_response, status: 200)

        response = client.push(message)

        expect(response).to be_success
        expect(response.value!).to have_attributes(
          status_code: 200,
          status_message: 'OK',
          body: { 'Messages' => ['68E6-A2D7D277-9695F410'] }
        )
      end

      it 'returns failure if something went wrong on http level' do
        stub_request(:post, action_url)
          .with(headers: headers, body: request_body)
          .to_return(headers: response_headers, body: '', status: 500)

        response = client.push(message)

        expect(response).to be_failure
        expect(response.failure).to have_attributes(
          status_code: 500,
          status_message: 'Internal Server Error',
          body: nil
        )
      end

      it 'returns failure if something went wrong on api level' do
        stub_request(:post, action_url)
          .with(headers: headers, body: request_body)
          .to_return(headers: response_headers, body: fail_response, status: 200)

        response = client.push(message)

        expect(response).to be_failure
        expect(response.failure).to have_attributes(
          status_code: 210,
          status_message: 'Preset code is wrong',
          body: { 'Messages' => [] }
        )
      end

      it 'handles default http timeout' do
        stub_request(:post, action_url)
          .with(headers: headers, body: request_body)
          .to_timeout

        response = client.push(message)

        expect(response).to be_failure
        expect(response.failure).to be_a(HTTP::TimeoutError)
      end
    end
  end
end
