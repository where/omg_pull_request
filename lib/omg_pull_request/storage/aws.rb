module OmgPullRequest
  module Storage 
    class Aws
      attr_accessor :configuration, :github_wrapper
      def initialize(attributes={})
        attributes.each do |attr, value|
          self.send("#{attr}=", value)
        end

        AWS::S3::Base.establish_connection!(
          :access_key_id     => access_token,
          :secret_access_key => secret_token
        )
      end

      def store(data, file_name)
        AWS::S3::S3Object.store(file_name, data, bucket, :access => :public_read)
        "http://s3.amazonaws.com/#{bucket}/#{file_name}"
      end

      private

      [:access_token, :secret_token, :bucket].each do |attr|
        define_method attr do
          configuration.storage[attr.to_s]
        end
      end
    end
  end
end
