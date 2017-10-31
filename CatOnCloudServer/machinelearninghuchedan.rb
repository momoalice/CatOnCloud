require "google/cloud/vision"


def updated? ()
  true
end


def suggest_similar(target,img_path)
  project_id = "clean-sequencer-183609"
  vision = Google::Cloud::Vision.new project: project_id

#if already written, go to solution
if (updated?)
  keys = []
  data = {}
  data.default = []
  bestImages = {}
  bestImages.default = 1.0

  Dir.foreach(img_path) do |img_file|
    next if img_file == '.' or img_file == '..'
    keys.push(img_path+'/'+ img_file)
  end

  keys.each do |file|
    data[file] = (vision.image file).labels
  end
  puts "updated"

  keys.each do |file|
    if (file != target)
      data.fetch(file, nil).each do |dest_label|
           data.fetch(target, nil).each do |origin_label|
            if (origin_label.description == dest_label.description)
              diff = (1.0 - (dest_label.score - origin_label.score))
              bestImages[file] = bestImages.fetch(file,1.0) * diff
            end
          end
        end
      end
    end
    puts Hash[bestImages.sort.reverse].keys
  end
end

suggest_similar("./img/img4.jpg","./img")
