 WickedPdf.config[:exe_path] = File.join(Rails.root, 'bin', 'wkhtmltopdf', 'wkhtmltopdf.exe')

 def wicked_pdf_stylesheet_link_tag(*sources)
    sources.collect do |source|
      asset = Rails.application.assets.find_asset("#{source}.css")

      if asset.nil?
        raise "could not find asset for #{source}.css"
      else
        puts "="*50
        puts "<style type='text/css'>#{asset.body}</style>"
        puts "="*50
        "<style type='text/css'>#{asset.body}</style>"
      end
    end.join("\n").gsub(/url\(['"](.+)['"]\)(.+)/,%[url("#{wicked_pdf_image_location("\1")}")\2]).html_safe
end