require_relative "./uploader"

class Delta
  include Sidekiq::Worker

  def perform(id)

    # TODO: Dropbox client for given user id
    result = client.metadata("/tactics/")

    puts result.inspect

    result["contents"].each do |data|
      path = data["path"]
      is_dir = data["is_dir"]
      puts path

      unless is_dir
        Uploader.perform_async(path)
      end
    end

  end

  def client
    @client ||= DropboxClient.new(TOKEN)
  end
end
