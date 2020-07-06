require 'award'

TYPES = ['Blue First', 'Blue Compare', 'Blue Distinction Plus']

def update_quality(awards)
  awards.each do |award|
    if(!(TYPES.include? award.name))
      award.quality -= 1  if award.quality > 0 
    else
      if award.quality < 50
        award.quality += 1
        if award.name == 'Blue Compare'
          award.quality += 1 if award.expires_in < 11
          award.quality += 1 if award.expires_in < 6
        end
      end
    end
    
    award.expires_in -= 1 if(award.name != 'Blue Distinction Plus')

    if award.expires_in < 0
      award.quality -= 1 if(!(TYPES.include? award.name) && award.quality > 0)
      award.quality -= award.quality if award.name == 'Blue Compare'
      award.quality += 1 if award.quality < 50 && award.name == 'Blue First'
    end
  end
end
