PATTERN = /page=(\S+)/

use Rack::Static,
  urls: ["/i"],
  root: "public"

run ->(env) {
  matched = env['QUERY_STRING'].match(PATTERN)
  page_name = matched ? matched[1] : "digest"

  [
    200,
    {
      'Content-Type'  => 'text/html',
      'Cache-Control' => 'public, max-age=86400'
    },
    File.open("public/#{page_name}.html", File::RDONLY)
  ]
}
