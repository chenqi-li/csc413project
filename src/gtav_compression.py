from PIL import Image
import os
from tqdm import tqdm


def compress(image_file, output_file, level):
    
    filepath = os.path.join(os.getcwd(), image_file)

    image = Image.open(filepath)

    image.save(output_file, 
                 "JPEG", 
                 optimize = True, 
                 quality = level,
                 subsampling=0)
    return



if __name__ == "__main__":
    gtav_dir = '/home/data/images'
    compression_level = [90,70,50,30,10]

    for lv in compression_level:
        print(f'Compressing level:{lv}')
        if os.path.exists(gtav_dir+str(lv)):
            continue
        else:
            os.makedirs(gtav_dir+str(lv))

        for img in tqdm(os.listdir(gtav_dir)):
            if img[-4:] == '.png':
                compress(image_file=os.path.join(gtav_dir, img), output_file=os.path.join(gtav_dir+str(lv), img), level=lv)