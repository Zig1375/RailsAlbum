class PhotoUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick
    storage :file

    def extension_whitelist
        %w(jpg jpeg gif png)
    end

    version :thumb do
        process resize_to_fill: [260,260]
    end
end