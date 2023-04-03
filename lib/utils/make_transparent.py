from PIL import Image


def main():
  print('hello')
  filename = r'C:/Dev/SoftwareProjects/FlutterProjects/yase/assets/minus.png'
  im = Image.open(filename)
  img = im.convert("RGBA")
  width = img.size[0]
  height = img.size[1]
  for x in range(0, width):  # process all pixels
    for y in range(0, height):
      data = img.getpixel((x, y))
      print(data)
      if (data[0] == 163 and data[1] == 73 and data[2] == 164):
        print(f'got it: data: {data}')
        img.putpixel((x, y), (255, 255, 255, 0))
  img.save(filename)
