module Pwush
  class Message < Dry::Struct
    # https://www.pushwoosh.com/v1.0/reference#createmessage

    constructor_type :strict_with_defaults

    # YYYY-MM-DD HH:mm  OR 'now'
    attribute :send_date, Types::Strict::String.default('now')

    attribute :ignore_user_timezone, Types::Strict::Bool.default(true)

    # "timezone":"America/New_York", optional, if ignored UTC-0 is default in "send_date".
    # See http://php.net/manual/timezones.php for supported timezones
    attribute :timezone, Types::Strict::String.optional.default(nil)

    # "campaign":"CAMPAIGN_CODE", optional.
    # Campaign code to which you want to assign this push message
    attribute :campaign, Types::Strict::String.optional.default(nil)

    # "content":{
    #    "en":"English",
    #    "ru":"Русский",
    #    "de":"Deutsch"
    # },
    attribute :content, Types::Strict::String | Types::Hash

    #  "page_id": 39, optional. HTML Pages. integer
    attribute :page_id, Types::Strict::Int.optional.default(nil)

    # "rich_page_id": 42, optional. Rich Pages. integer
    attribute :rich_page_id, Types::Strict::Int.optional.default(nil)

    # "rich_media": "XXXX-XXXX", optional. Rich Media code. string
    attribute :rich_media, Types::Strict::String.optional.default(nil)

    # "remote_page" : "http://myremoteurl.com",
    # Remote Rich HTML Page URL. <scheme>://<authority>
    attribute :remote_page, Types::Strict::String.optional.default(nil)

    # "link": "http://google.com", optional, string.
    # For deeplinks add "minimize_link":0
    attribute :link, Types::Strict::String.optional.default(nil)

    # "minimize_link": 0, optional.
    # False or 0 - do not minimize, 1 - Google, 2 - bitly. Default = 1
    attribute :minimize_link, Types::Strict::Int.constrained(included_in: 0..2).optional.default(nil)

    # "data": {"key":"value"}, JSON string or JSON object,
    # will be passed as "u" parameter in the payload (converted to JSON string)
    attribute :data, (Types::Strict::String | Types::Hash).optional.default(nil)

    # 1 - iOS; 2 - BB; 3 - Android; 5 - Windows Phone; 7 - OS X; 8 - Windows 8;
    # 9 - Amazon; 10 - Safari; 11 - Chrome; 12 - Firefox;
    # ignored if "devices" < 10
    Platforms = Types::Strict::Int.enum(1, 2, 3, 5, 7, 8, 9, 10, 11, 12)
    attribute :platforms, Types::Strict::Array.of(Platforms).optional.default(nil)

    # "preset":"Q1A2Z-6X8SW", Push Preset Code from your Control Panel
    attribute :preset, Types::Strict::String.optional.default(nil)

    # "send_rate": 100, throttling. Valid values are from 100 to 1000 pushes/second.
    attribute :send_rate, Types::Strict::Int.constrained(included_in: 100..1000).optional.default(nil)

    # Optional. Specify tokens or hwids to send targeted push notifications.
    # Not more than 1000 tokens/hwids in an array.
    # If set, the message will only be sent to the devices on the list.
    # Ignored if the Applications Group is used. iOS push tokens can only be lower case.
    attribute :devices, Types::Strict::Array.of(Types::Strict::String).optional.default(nil)

    # "users":["user_3078a"], optional.
    # If set, message will only be delivered to the specified users Id's
    # (specified via /registerUser call).
    # If specified together with devices parameter, the latter will be ignored.
    attribute :users, Types::Strict::Array.of(Types::Strict::String).optional.default(nil)

    #  "filter": "FILTER_NAME", optional.
    attribute :filter, Types::Strict::String.optional.default(nil)

    #  optional, placeholders for dynamic content instead of device tags
    #  "dynamic_content_placeholders" :{
    #      "firstname":"John",
    #      "lastname":"Doe"
    #  },
    attribute :dynamic_content_placeholders, Types::Hash.optional.default(nil)

    # "conditions": [TAG_CONDITION1, TAG_CONDITION2, ..., TAG_CONDITIONN],
    # Optional.
    attribute :conditions, Types::Strict::Array.of(Types::Strict::String).optional.default(nil)

    # iOS related

    # "ios_badges": 5, optional, integer.
    # iOS application badge number.
    # Use "+n" or "-n" to increment/decrement the badge value by n
    attribute :ios_badges, Types::Strict::Int.optional.default(nil)

    # "ios_sound": "sound file.wav", optional.
    # Sound file name in the main bundle of application.
    # If left empty, the device will produce no sound upon receiving a push
    attribute :ios_sound, Types::Strict::String.optional.default(nil)

    # "ios_ttl": 3600, optional.
    # Time to live parameter - maximum message lifespan in seconds
    attribute :ios_ttl, Types::Strict::Int.optional.default(nil)

    # "ios_silent": 1, optional.
    # Enable silent notifications (ignore "sound" and "content")
    attribute :ios_silent, Types::Strict::Int.constrained(included_in: 0..1).optional.default(nil)

    # iOS8 category ID from Pushwoosh
    attribute :ios_category_id, Types::Strict::Int.optional.default(nil)

    # Optional - root level parameters to the aps dictionary
    # "ios_root_params" : {
    #    "aps":{
    #      "content-available": "1",
    #      "mutable-content":1 //required for iOS 10 Media attachments
    #   },
    #    "attachment":"YOUR_ATTACHMENT_URL", // iOS 10 media attachment URL
    #   "data": << User supplied data, max of 4KB>>
    #  },
    attribute :ios_root_params, Types::Hash.optional.default(nil)

    #  "apns_trim_content":1, optional. (0|1)
    # Trims the exceeding content strings with ellipsis
    attribute :apns_trim_content, Types::Strict::Int.constrained(included_in: 0..1).optional.default(nil)

    # "ios_title":"Title", optional. Add Title for push notification
    attribute :ios_title, Types::Strict::String.optional.default(nil)

    # "ios_subtitle" : "SubTitle", //Optional. Added sub-title for push notification
    attribute :ios_subtitle, Types::Strict::String.optional.default(nil)

    # Android related

    # "android_root_params": {"key": "value"}
    # custom key-value object. root level parameters for the android payload recipients
    attribute :android_root_params, Types::Hash.optional.default(nil)

    # "android_sound" : "soundfile", optional. No file extension.
    # If left empty, the device will produce no sound upon receiving a push
    attribute :android_sound, Types::Strict::String.optional.default(nil)

    # "android_header":"header", optional. Android notification header
    attribute :android_header, Types::Strict::String.optional.default(nil)

    # "android_icon": "icon",
    attribute :android_icon, Types::Strict::String.optional.default(nil)

    # "android_custom_icon": "http://example.com/image.png", optional.
    # Full path URL to the image file
    attribute :android_custom_icon, Types::Strict::String.optional.default(nil)

    # "android_banner": "http://example.com/banner.png", optional.
    # Full path URL to the image file
    attribute :android_banner, Types::Strict::String.optional.default(nil)

    # "android_badges": 5, optional, integer.
    # Android application icon badge number.
    # Use "+n" or "-n" to increment/decrement the badge value by n
    attribute :android_badges, Types::Strict::Int.optional.default(nil)

    # "android_gcm_ttl": 3600, optional.
    # Time to live parameter - maximum message lifespan in seconds
    attribute :android_gcm_ttl, Types::Strict::Int.optional.default(nil)

    # "android_vibration": 0, Android force-vibration for high-priority pushes, boolean
    attribute :android_vibration, Types::Strict::Bool.optional.default(nil)

    # "android_led":"#rrggbb", LED hex color, device will do its best approximation
    attribute :android_led, Types::Strict::String.optional.default(nil)

    # "android_priority":-1,  priority of the push in the Android push drawer.
    # Valid values are -2, -1, 0, 1 and 2
    attribute :android_priority, Types::Strict::Int.constrained(included_in: -2..2).optional.default(nil)

    # "android_ibc":"#RRGGBB", icon background color on Lollipop,
    # #RRGGBB, #AARRGGBB, "red", "black", "yellow", etc.
    attribute :android_ibc, Types::Strict::String.optional.default(nil)

    # "android_silent": 1, optional. 0 or 1
    # Enable silent notificaiton (ignore sound and content)
    attribute :android_silent, Types::Strict::Int.constrained(included_in: 0..1).optional.default(nil)

    # Amazon related

    # "adm_root_params": {"key": "value"}, // custom key-value object
    attribute :adm_root_params, Types::Hash.optional.default(nil)
    # "adm_sound": "push.mp3",
    attribute :adm_sound, Types::Strict::String.optional.default(nil)
    # "adm_header": "Header",
    attribute :adm_header, Types::Strict::String.optional.default(nil)
    # "adm_icon": "icon",
    attribute :adm_icon, Types::Strict::String.optional.default(nil)
    # "adm_custom_icon": "http://example.com/image.png",
    attribute :adm_custom_icon, Types::Strict::String.optional.default(nil)
    # "adm_banner": "http://example.com/banner.png",
    attribute :adm_banner, Types::Strict::String.optional.default(nil)
    # "adm_ttl": 3600, optional. Time to live parameter - the maximum message lifespan in seconds
    attribute :adm_ttl, Types::Strict::Int.optional.default(nil)
    # "adm_priority":-1, priority of the push in Amazon push drawer, valid values are -2, -1, 0, 1 and 2
    attribute :adm_priority, Types::Strict::Int.optional.default(nil)

    # Windows Phone related

    # Windows Phone notification type. 'Tile' or 'Toast'. Raw notifications are not supported. 'Tile' if default
    attribute :wp_type, Types::Strict::String.optional.default(nil)
    # tile image
    attribute :wp_background, Types::Strict::String.optional.default(nil)
    # back tile image
    attribute :wp_backbackground, Types::Strict::String.optional.default(nil)
    # back tile title
    attribute :wp_backtitle, Types::Strict::String.optional.default(nil)
    # back tile content
    attribute :wp_backcontent, Types::Strict::String.optional.default(nil)
    # Badge for Windows Phone notification
    attribute :wp_count, Types::Strict::Int.optional.default(nil)

    # BlackBerry related

    # BlackBerry header, applicable to BB10 Series devices
    attribute :blackberry_header, Types::Strict::String.optional.default(nil)

    # Mac OS X related

    # "mac_badges": 3,
    attribute :mac_badges, Types::Strict::Int.optional.default(nil)
    # "mac_sound": "sound.caf",
    attribute :mac_sound, Types::Strict::String.optional.default(nil)
    # "mac_root_params": {"content-available":1},
    attribute :mac_root_params, Types::Hash.optional.default(nil)
    # Time to live parameter — maximum message lifespan in seconds
    attribute :mac_ttl, Types::Strict::Int.optional.default(nil)

    # WNS related

    # Content (XML or raw) of notification encoded in MIME's base64 in form of Object( language1: 'content1', language2: 'content2' ) OR String
    #     "en": "PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz48YmFkZ2UgdmFsdWU9ImF2YWlsYWJsZSIvPg==",
    #     "de": "PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz48YmFkZ2UgdmFsdWU9Im5ld01lc3NhZ2UiLz4="
    #  },
    attribute :wns_content, Types::Hash.optional.default(nil)
    # 'Tile' | 'Toast' | 'Badge' | 'Raw'
    attribute :wns_type, Types::Strict::String.optional.default(nil)
    #  optional. Used in Tile replacement policy. An alphanumeric string of no more than 16 characters.
    attribute :wns_tag, Types::Strict::String.optional.default(nil)
    #  optional. (1|0) Translates into X-WNS-Cache-Policy value
    attribute :wns_cache, Types::Strict::Int.optional.default(nil)
    #  optional. Expiration time for notification in seconds
    attribute :wns_ttl, Types::Strict::Int.optional.default(nil)

    # Safari related

    # obligatory, title of the notification
    attribute :safari_title, Types::Strict::String.optional.default(nil)

    # "safari_action": "Click here", // optional
    attribute :safari_action, Types::Strict::String.optional.default(nil)

    # "safari_url_args": ["firstArgument", "secondArgument"],
    # Obligatory, but the value may be empty
    attribute :safari_url_args, Types::Strict::Array.of(Types::Strict::String).optional.default(nil)

    # Optional. Time to live parameter - the maximum lifespan of a message in seconds
    attribute :safari_ttl, Types::Strict::Int.constrained(min_size: 0).optional.default(nil)

    # Chrome related

    # You can specify the header of the message in this parameter
    attribute :chrome_title, Types::Strict::String.optional.default(nil)

    # "chrome_icon":"", full path URL to the icon or extension resources file path
    attribute :chrome_icon, Types::Strict::String.optional.default(nil)

    # Time to live parameter - maximum message lifespan in seconds
    attribute :chrome_gcm_ttl, Types::Strict::Int.optional.default(nil)

    # optional, changes chrome push display time.
    # Set to 0 to display push until user interacts with it
    attribute :chrome_duration, Types::Strict::Int.optional.default(nil)

    # optional, URL to large image.
    attribute :chrome_image, Types::Strict::String.optional.default(nil)

    attribute :chrome_button_text1, Types::Strict::String.optional.default(nil)

    # ignored if chrome_button_text1 is not set
    attribute :chrome_button_url1, Types::Strict::String.optional.default(nil)

    attribute :chrome_button_text2, Types::Strict::String.optional.default(nil)

    # ignored if chrome_button_text2 is not set
    attribute :chrome_button_url2, Types::Strict::String.optional.default(nil)

    # Firefox-related

    # optional. You can specify message header here
    attribute :firefox_title, Types::Strict::String.optional.default(nil)

    # full path URL to the icon or path to the file in extension resources
    attribute :firefox_icon, Types::Strict::String.optional.default(nil)

    def defined_attributes
      __attributes__.reject { |_, v| v.nil? }
    end

    def to_json(options = nil)
      defined_attributes.to_json(options)
    end

    def inspect
      attrs = defined_attributes.map { |k, v| " #{k}=#{v.inspect}" }.join
      "#<#{self.class}#{attrs}>"
    end
  end
end
