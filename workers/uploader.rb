class Uploader
  include Sidekiq::Worker

  def perform(path)
    puts path

    content = client.get_file(path)

    bucket.files.create(
      :key => path.sub('/tactics/', ''),
      :body => content,
      :public => true
    )
  end

  def client
    @client ||= DropboxClient.new(TOKEN)
  end

  def bucket
    connection = Fog::Storage.new({
      :provider                 => 'AWS',
      :aws_access_key_id        => S3_KEY,
      :aws_secret_access_key    => S3_SECRET,
    })

    connection.directories.get("distri-tactics")
  end
end
