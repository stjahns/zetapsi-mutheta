Paperclip::Attachment.default_options[:s3_host_name] = 's3-us-west-2.amazonaws.com'

module Paperclip
  module Storage
    module S3
      def expiring_url(style = default_tyle, time = 3600)
        s3_object(style).url_for(:read, :expires_in => time, :secure => true)
      end
    end
  end
end
