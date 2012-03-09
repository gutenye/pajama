max_pic_size = 1*1024*1024 

p:
  root = Pa.dir(__FILE__).parent(2)
	project = Pa("~/gooten")
  home = Pa("~/.pajama")

  new = Pa("~/gooten/new")
	release = Pa("~/gooten/release")
  archive = project

	mount_point  = Pa("/media/camera")
	watermark = Pa("~/gooten/watermark.png")

o:
  watermark = [0.5, 0, 0]

# vim: ft=ruby
