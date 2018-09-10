module Pwush
  class Message < Dry::Struct
    # transform_types do |type|
    #   type.constructor { |value| value.nil? ? Undefined : value }
    # end
    # https://www.pushwoosh.com/v1.0/reference#createmessage

    # YYYY-MM-DD HH:mm  OR 'now'
    attribute :send_date, Types::Strict::String.default('now')

    attribute :ignore_user_timezone, Types::Strict::Bool.default(true)

    # "timezone":"America/New_York", optional, if ignored UTC-0 is default in "send_date".
    # See http://php.net/manual/timezones.php for supported timezones
    attribute :timezone, Types::Strict::String.meta(omittable: true)

    # "campaign":"CAMPAIGN_CODE", optional.
    # Campaign code to which you want to assign this push message
    attribute :campaign, Types::Strict::String.meta(omittable: true)

    # "content":{
    #    "en":"English",
    #    "ru":"Русский",
    #    "de":"Deutsch"
    # },
    attribute :content, Types::Strict::String | Types::Hash

    #  "page_id": 39, optional. HTML Pages. integer
    attribute :page_id, Types::Strict::Integer.meta(omittable: true)

    # "rich_page_id": 42, optional. Rich Pages. integer
    attribute :rich_page_id, Types::Strict::Integer.meta(omittable: true)

    # "rich_media": "XXXX-XXXX", optional. Rich Media code. string
    attribute :rich_media, Types::Strict::String.meta(omittable: true)

    # "remote_page" : "http://myremoteurl.com",
    # Remote Rich HTML Page URL. <scheme>://<authority>
    attribute :remote_page, Types::Strict::String.meta(omittable: true)

    # "link": "http://google.com", optional, string.
    # For deeplinks add "minimize_link":0
    attribute :link, Types::Strict::String.meta(omittable: true)

    # "minimize_link": 0, optional.
    # False or 0 - do not minimize, 1 - Google, 2 - bitly. Default = 1
    attribute :minimize_link, Types::Strict::Integer.constrained(included_in: 0..2)
                                                    .meta(omittable: true)

    # "data": {"key":"value"}, JSON string or JSON object,
    # will be passed as "u" parameter in the payload (converted to JSON string)
    attribute :data, (Types::Strict::String | Types::Hash).meta(omittable: true)

    # 1 - iOS; 2 - BB; 3 - Android; 5 - Windows Phone; 7 - OS X; 8 - Windows 8;
    # 9 - Amazon; 10 - Safari; 11 - Chrome; 12 - Firefox;
    # ignored if "devices" < 10
    Platforms = Types::Strict::Integer.enum(1, 2, 3, 5, 7, 8, 9, 10, 11, 12)
    attribute :platforms, Types::Strict::Array.of(Platforms).meta(omittable: true)

    # "preset":"Q1A2Z-6X8SW", Push Preset Code from your Control Panel
    attribute :preset, Types::Strict::String.meta(omittable: true)

    # "send_rate": 100, throttling. Valid values are from 100 to 1000 pushes/second.
    attribute :send_rate, Types::Strict::Integer.constrained(included_in: 100..1000)
                                                .meta(omittable: true)

    # Optional. Specify tokens or hwids to send targeted push notifications.
    # Not more than 1000 tokens/hwids in an array.
    # If set, the message will only be sent to the devices on the list.
    # Ignored if the Applications Group is used. iOS push tokens can only be lower case.
    attribute :devices, Types::Strict::Array.of(Types::Strict::String)
                                            .meta(omittable: true)

    # "users":["user_3078a"], optional.
    # If set, message will only be delivered to the specified users Id's
    # (specified via /registerUser call).
    # If specified together with devices parameter, the latter will be ignored.
    attribute :users, Types::Strict::Array.of(Types::Strict::String)
                                          .meta(omittable: true)

    #  "filter": "FILTER_NAME", optional.
    attribute :filter, Types::Strict::String.meta(omittable: true)

    #  optional, placeholders for dynamic content instead of device tags
    #  "dynamic_content_placeholders" :{
    #      "firstname":"John",
    #      "lastname":"Doe"
    #  },
    attribute :dynamic_content_placeholders, Types::Hash.meta(omittable: true)

    # "conditions": [TAG_CONDITION1, TAG_CONDITION2, ..., TAG_CONDITIONN],
    # Optional.
    attribute :conditions, Types::Strict::Array.of(Types::Strict::String)
                                               .meta(omittable: true)

    # iOS related

    # "ios_badges": 5, optional, integer.
    # iOS application badge number.
    # Use "+n" or "-n" to increment/decrement the badge value by n
    attribute :ios_badges, Types::Strict::Integer.meta(omittable: true)

    # "ios_sound": "sound file.wav", optional.
    # Sound file name in the main bundle of application.
    # If left empty, the device will produce no sound upon receiving a push
    attribute :ios_sound, Types::Strict::String.meta(omittable: true)

    # "ios_ttl": 3600, optional.
    # Time to live parameter - maximum message lifespan in seconds
    attribute :ios_ttl, Types::Strict::Integer.meta(omittable: true)

    # "ios_silent": 1, optional.
    # Enable silent notifications (ignore "sound" and "content")
    attribute :ios_silent, Types::Strict::Integer.constrained(included_in: 0..1)
                                                 .meta(omittable: true)

    # iOS8 category ID from Pushwoosh
    attribute :ios_category_id, Types::Strict::Integer.meta(omittable: true)

    # Optional - root level parameters to the aps dictionary
    # "ios_root_params" : {
    #    "aps":{
    #      "content-available": "1",
    #      "mutable-content":1 //required for iOS 10 Media attachments
    #   },
    #    "attachment":"YOUR_ATTACHMENT_URL", // iOS 10 media attachment URL
    #   "data": << User supplied data, max of 4KB>>
    #  },
    attribute :ios_root_params, Types::Hash.meta(omittable: true)

    #  "apns_trim_content":1, optional. (0|1)
    # Trims the exceeding content strings with ellipsis
    attribute :apns_trim_content, Types::Strict::Integer.constrained(included_in: 0..1)
                                                        .meta(omittable: true)

    # "ios_title":"Title", optional. Add Title for push notification
    attribute :ios_title, Types::Strict::String.meta(omittable: true)

    # "ios_subtitle" : "SubTitle", //Optional. Added sub-title for push notification
    attribute :ios_subtitle, Types::Strict::String.meta(omittable: true)

    # Android related

    # "android_root_params": {"key": "value"}
    # custom key-value object. root level parameters for the android payload recipients
    attribute :android_root_params, Types::Hash.meta(omittable: true)

    # "android_sound" : "soundfile", optional. No file extension.
    # If left empty, the device will produce no sound upon receiving a push
    attribute :android_sound, Types::Strict::String.meta(omittable: true)

    # "android_header":"header", optional. Android notification header
    attribute :android_header, Types::Strict::String.meta(omittable: true)

    # "android_icon": "icon",
    attribute :android_icon, Types::Strict::String.meta(omittable: true)

    # "android_custom_icon": "http://example.com/image.png", optional.
    # Full path URL to the image file
    attribute :android_custom_icon, Types::Strict::String.meta(omittable: true)

    # "android_banner": "http://example.com/banner.png", optional.
    # Full path URL to the image file
    attribute :android_banner, Types::Strict::String.meta(omittable: true)

    # "android_badges": 5, optional, integer.
    # Android application icon badge number.
    # Use "+n" or "-n" to increment/decrement the badge value by n
    attribute :android_badges, Types::Strict::Integer.meta(omittable: true)

    # "android_gcm_ttl": 3600, optional.
    # Time to live parameter - maximum message lifespan in seconds
    attribute :android_gcm_ttl, Types::Strict::Integer.meta(omittable: true)

    # "android_vibration": 0, Android force-vibration for high-priority pushes, boolean
    attribute :android_vibration, Types::Strict::Bool.meta(omittable: true)

    # "android_led":"#rrggbb", LED hex color, device will do its best approximation
    attribute :android_led, Types::Strict::String.meta(omittable: true)

    # "android_priority":-1,  priority of the push in the Android push drawer.
    # Valid values are -2, -1, 0, 1 and 2
    attribute :android_priority, Types::Strict::Integer.constrained(included_in: -2..2)
                                                       .meta(omittable: true)

    # "android_ibc":"#RRGGBB", icon background color on Lollipop,
    # #RRGGBB, #AARRGGBB, "red", "black", "yellow", etc.
    attribute :android_ibc, Types::Strict::String.meta(omittable: true)

    # "android_silent": 1, optional. 0 or 1
    # Enable silent notificaiton (ignore sound and content)
    attribute :android_silent, Types::Strict::Integer.constrained(included_in: 0..1)
                                                     .meta(omittable: true)

    # Amazon related

    # "adm_root_params": {"key": "value"}, // custom key-value object
    attribute :adm_root_params, Types::Hash.meta(omittable: true)
    # "adm_sound": "push.mp3",
    attribute :adm_sound, Types::Strict::String.meta(omittable: true)
    # "adm_header": "Header",
    attribute :adm_header, Types::Strict::String.meta(omittable: true)
    # "adm_icon": "icon",
    attribute :adm_icon, Types::Strict::String.meta(omittable: true)
    # "adm_custom_icon": "http://example.com/image.png",
    attribute :adm_custom_icon, Types::Strict::String.meta(omittable: true)
    # "adm_banner": "http://example.com/banner.png",
    attribute :adm_banner, Types::Strict::String.meta(omittable: true)
    # "adm_ttl": 3600, optional. Time to live parameter - the maximum message lifespan in seconds
    attribute :adm_ttl, Types::Strict::Integer.meta(omittable: true)
    # "adm_priority":-1, priority of the push in Amazon push drawer, valid values are -2, -1, 0, 1 and 2
    attribute :adm_priority, Types::Strict::Integer.meta(omittable: true)

    # Windows Phone related

    # Windows Phone notification type. 'Tile' or 'Toast'. Raw notifications are not supported. 'Tile' if default
    attribute :wp_type, Types::Strict::String.meta(omittable: true)
    # tile image
    attribute :wp_background, Types::Strict::String.meta(omittable: true)
    # back tile image
    attribute :wp_backbackground, Types::Strict::String.meta(omittable: true)
    # back tile title
    attribute :wp_backtitle, Types::Strict::String.meta(omittable: true)
    # back tile content
    attribute :wp_backcontent, Types::Strict::String.meta(omittable: true)
    # Badge for Windows Phone notification
    attribute :wp_count, Types::Strict::Integer.meta(omittable: true)

    # BlackBerry related

    # BlackBerry header, applicable to BB10 Series devices
    attribute :blackberry_header, Types::Strict::String.meta(omittable: true)

    # Mac OS X related

    # "mac_badges": 3,
    attribute :mac_badges, Types::Strict::Integer.meta(omittable: true)
    # "mac_sound": "sound.caf",
    attribute :mac_sound, Types::Strict::String.meta(omittable: true)
    # "mac_root_params": {"content-available":1},
    attribute :mac_root_params, Types::Hash.meta(omittable: true)
    # Time to live parameter — maximum message lifespan in seconds
    attribute :mac_ttl, Types::Strict::Integer.meta(omittable: true)

    # WNS related

    # Content (XML or raw) of notification encoded in MIME's base64 in form of Object( language1: 'content1', language2: 'content2' ) OR String
    #     "en": "PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz48YmFkZ2UgdmFsdWU9ImF2YWlsYWJsZSIvPg==",
    #     "de": "PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz48YmFkZ2UgdmFsdWU9Im5ld01lc3NhZ2UiLz4="
    #  },
    attribute :wns_content, Types::Hash.meta(omittable: true)
    # 'Tile' | 'Toast' | 'Badge' | 'Raw'
    attribute :wns_type, Types::Strict::String.meta(omittable: true)
    #  optional. Used in Tile replacement policy. An alphanumeric string of no more than 16 characters.
    attribute :wns_tag, Types::Strict::String.meta(omittable: true)
    #  optional. (1|0) Translates into X-WNS-Cache-Policy value
    attribute :wns_cache, Types::Strict::Integer.meta(omittable: true)
    #  optional. Expiration time for notification in seconds
    attribute :wns_ttl, Types::Strict::Integer.meta(omittable: true)

    # Safari related

    # obligatory, title of the notification
    attribute :safari_title, Types::Strict::String.meta(omittable: true)

    # "safari_action": "Click here", // optional
    attribute :safari_action, Types::Strict::String.meta(omittable: true)

    # "safari_url_args": ["firstArgument", "secondArgument"],
    # Obligatory, but the value may be empty
    attribute :safari_url_args, Types::Strict::Array.of(Types::Strict::String)
                                                    .meta(omittable: true)

    # Optional. Time to live parameter - the maximum lifespan of a message in seconds
    attribute :safari_ttl, Types::Strict::Integer.constrained(min_size: 0)
                                                 .meta(omittable: true)

    # Chrome related

    # You can specify the header of the message in this parameter
    attribute :chrome_title, Types::Strict::String.meta(omittable: true)

    # "chrome_icon":"", full path URL to the icon or extension resources file path
    attribute :chrome_icon, Types::Strict::String.meta(omittable: true)

    # Time to live parameter - maximum message lifespan in seconds
    attribute :chrome_gcm_ttl, Types::Strict::Integer.meta(omittable: true)

    # optional, changes chrome push display time.
    # Set to 0 to display push until user interacts with it
    attribute :chrome_duration, Types::Strict::Integer.meta(omittable: true)

    # optional, URL to large image.
    attribute :chrome_image, Types::Strict::String.meta(omittable: true)

    attribute :chrome_button_text1, Types::Strict::String.meta(omittable: true)

    # ignored if chrome_button_text1 is not set
    attribute :chrome_button_url1, Types::Strict::String.meta(omittable: true)

    attribute :chrome_button_text2, Types::Strict::String.meta(omittable: true)

    # ignored if chrome_button_text2 is not set
    attribute :chrome_button_url2, Types::Strict::String.meta(omittable: true)

    # Firefox-related

    # optional. You can specify message header here
    attribute :firefox_title, Types::Strict::String.meta(omittable: true)

    # full path URL to the icon or path to the file in extension resources
    attribute :firefox_icon, Types::Strict::String.meta(omittable: true)

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
