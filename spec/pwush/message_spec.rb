RSpec.describe Pwush::Message do
  subject(:message) { described_class }

  let(:default_attributes) {
    {
      send_date: 'now',
      ignore_user_timezone: true,
      timezone: 'UTC-0',
      campaign: nil,
      page_id: nil,
      rich_page_id: nil,
      rich_media: nil,
      remote_page: nil,
      link: nil,
      minimize_link: 1,
      data: nil,
      platforms: nil,
      preset: nil,
      send_rate: nil,
      devices: nil,
      users: nil,
      filter: nil,
      dynamic_content_placeholders: nil,
      conditions: nil,
      ios_badges: nil,
      ios_sound: nil,
      ios_ttl: nil,
      ios_silent: nil,
      ios_category_id: nil,
      ios_root_params: nil,
      apns_trim_content: nil,
      ios_title: nil,
      ios_subtitle: nil,
      android_root_params: nil,
      android_sound: nil,
      android_header: nil,
      android_icon: nil,
      android_custom_icon: nil,
      android_banner: nil,
      android_badges: nil,
      android_gcm_ttl: nil,
      android_vibration: nil,
      android_led: nil,
      android_priority: nil,
      android_ibc: nil,
      android_silent: nil,
      adm_root_params: nil,
      adm_sound: nil,
      adm_header: nil,
      adm_icon: nil,
      adm_custom_icon: nil,
      adm_banner: nil,
      adm_ttl: nil,
      adm_priority: nil,
      wp_type: nil,
      wp_background: nil,
      wp_backbackground: nil,
      wp_backtitle: nil,
      wp_backcontent: nil,
      wp_count: nil,
      blackberry_header: nil,
      mac_badges: nil,
      mac_sound: nil,
      mac_root_params: nil,
      mac_ttl: nil,
      wns_content: nil,
      wns_type: nil,
      wns_tag: nil,
      wns_cache: nil,
      wns_ttl: nil,
      safari_title: nil,
      safari_action: nil,
      safari_url_args: nil,
      safari_ttl: nil,
      chrome_title: nil,
      chrome_icon: nil,
      chrome_gcm_ttl: nil,
      chrome_duration: nil,
      chrome_image: nil,
      chrome_button_text1: nil,
      chrome_button_url1: nil,
      chrome_button_text2: nil,
      chrome_button_url2: nil,
      firefox_title: nil,
      firefox_icon: nil
    }
  }

  context 'with no attributes' do
    it 'raises error' do
      expect { message.new }.to raise_error(Dry::Struct::Error)
    end
  end

  context 'default attributes' do
    let(:attributes) {
      {
        content: '!'
      }
    }
    it 'inits with default values' do
      expect(message.new(attributes).__attributes__).to eq(
        default_attributes.merge(attributes)
      )
    end
  end
end
