from flask import Flask
from importlib import import_module
import os
import jsonpickle
from flask import Flask, Response, request, flash, url_for, jsonify
import logging
from logging.config import dictConfig
import numpy as np
from PIL import Image
from keras.models import load_model
from keras.preprocessing.image import load_img, img_to_array

app = Flask(__name__)


def load_image(filename):
    img = Image.open(filename)
    img = img.resize((200, 200))
    img_array = np.array(img) / 255
    return img_array


labels = ["Mae De Deus Church, Saligao", "Fort Aguada, Sinquerim", "Safa Masjid , Ponda", "St. Augustine Tower, Old Goa", "Shantadurga Temple, Ponda", "Se Cathedral, Old Goa", "Corjuem Fort, Aldona", "Our Lady of the Immaculate Conception Church, Panjim",
          "Chapel of Jesus Nazareth, Siridao", "Tiracol Fort", "Nagueshi Temple, Ponda", "Sinquerim Fort", "St. Cajetan Church, Old Goa", "Reis Magos Fort", "Three Kings Church, Cansaulim", "Ramnathi Temple, Ponda"]


def run_model(img):
    app.logger.error('Loading model')
    try:
        model = load_model('monuments1.h5')
    except FileNotFoundError as e:
        return abort('Unable to find the file: %s.' % str(e), 503)
    pred = model.predict(np.array([img]))
    print(pred)
    labels.sort()
    print(labels)
    check = np.max(pred[0])
    print("kujdweiuhfoaewighoirstjggpo;serjghoitrg", check)
    if(check < 0.42):
        return "0000"
    prediction = labels[np.argmax(pred[0])]
    print(prediction)
    return prediction


@app.route('/', methods=['GET'])
def hello_world():
    return 'Backend connection established'


@app.route('/predict', methods=['POST'])
def classify():
    app.logger.debug('Running classifier')
    upload = request.files['data']
    image = load_image(upload)
    print('image ready')
    try:
        prediction = run_model(image)
        return ({"prediction": prediction})
    except FileNotFoundError as e:
        return abort('Unable to locate image: %s.' % str(e), 503)
    except Exception as e:
        return abort('Unable to process image: %s.' % str(e), 500)


if __name__ == '__main__':
    app.secret_key = 'super_secret_key'
    app.debug = True
    app.run(host='127.0.0.1', port=5000)
