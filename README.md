Compressing GTAV Dataset
1. Download dataset from https://download.visinf.tu-darmstadt.de/data/from_games. Only the first two sets will be used for experiments to speed up training, use command `wget -c --no-check-certificate https://download.visinf.tu-darmstadt.de/data/from_games/data/01_images.zip` and `wget -c --no-check-certificate https://download.visinf.tu-darmstadt.de/data/from_games/data/02_images.zip`
3. Extract the zip and combine into `images` folder, with a total of 5,000 images
4. Change line 22 of `gtav_compression.py` to point to the `images` folder
5. Change line 22 of `gtav_compression.py` to set the compression levels, from 5 to 95, the higher the value the better the quality, each compression level takes around 8 minutes to  complete.

Compressed Dataset
https://drive.google.com/drive/u/1/folders/1ly7tkVppXgZQDcyX6HgNn5Qribt9Ilcv