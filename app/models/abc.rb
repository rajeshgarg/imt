 class Abc
	attr_accessor :data
  
  # def initialize(image)
	 #  @data = image
  # end
  
  # def preview
  #    painting1 = get_image
  #    # session["dd"] = StringIO.new(painting1.to_blob)
  #    @params=[params[:x],params[:y], params[:w], params[:h], params[:r]]
  #    session[:rotation] = params[:r].to_i or 0
  #   # painting1 = painting1.rotate(-90)  # for anti clockrotating the image
  #   # painting1 = painting1.rotate(90)  # for clock rotating the image
  #   # painting1 = painting1.flip # to flip image virtically
  #   # painting1 = painting1.transpose # to flip image virtically
  #   # painting1 = painting1.flop # to flip image virtically
  #   # painting1 = painting1.crop!(10, 10, 21, 26) # crop image 
  #   # painting1 = painting1.resize_to_fit(100,100)  
  #   # painting1 = painting1.resize(250,250)          
  # # response.headers["Content-type"] = painting1.mime_type
  #   # send_data(@fff, :type => painting1.mime_type,:disposition => 'inline')# (painting1.to_blob)
  #   # send =>"<img src= '"+ painting1.to_blob + "'/>"
  #    # format.js   { send_data @fff, :type => painting1.mime_type,:disposition => 'inline' }
  #   render :layout=>false
  #   # respond_to do |format|  
  #   # # format.html { render :text => painting1.to_blob }  
  #   # format.js #  { render :text =>  painting1.to_blob   }  
  #   # end     
     
  # end
   

  # def show_blob_image
  #   #puts session["dd"].data.to_blob
  #   image = session["dd"].data
  #   # get_image #Magick::Image.from_blob(session["dd"].read)[0]  #get_image
  #   response.headers["Content-type"] = image.mime_type
  #   format = params[:format] || [0,0,0,0]
  #   if format[2].to_i > 0 && format[3].to_i > 0 
  #   cropped_image = image.crop(format[0].to_i,format[1].to_i ,format[2].to_i, format[3].to_i)
  #   end
  #   cropped_image = cropped_image || image
  #   cropped_image = cropped_image.rotate(format[4].to_i)
   
  #   render :text=>cropped_image.to_blob #session[:blob_data]
  # end

  # def rotate
  #   render :layout=>false
     
  # end

  # def get_image
  #   abc = Abc.new
  #   painting1 = Magick::Image.read(Rails.root + "app/assets/images/dashboard/sbs/shop-small.png").first
  #   abc.data = painting1
  #   session["dd"] = abc
  #    # painting1 = Magick::Image.read(Rails.root + "app/assets/images/dashboard/sbs/shop-small.png").first #("/assets/signup/splash/cgm_logo.png")
     
  #    # Magick::Image.read("public" + painting.image_url(:thumb)).first if painting.image?
  # end
  # def croped img
  #   rect = Magick::Draw.new
  #   rect.stroke('transparent')
  #   rect.fill('white')
  #   rect.fill_opacity(0.25)
  #   rect.rectangle(195, 37, 16, 26)
  #   rect.draw(img)
  #   # bg = Magick::Image.new(img.columns, img.rows) {self.background_color="none"}
  #   # Composite the the "after" (chopped) image on the background
  #   # bg = bg.composite(img, 23, 81, Magick::OverCompositeOp)
  #   # bg.write('crop_after.png')
  # end
  
end
# class FileStringIO < StringIO
#   attr_accessor :original_filename
# end