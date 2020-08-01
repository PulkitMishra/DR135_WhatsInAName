import base64
import time
from io import BytesIO
from typing import Optional

import numpy as np
from PIL import Image

import cv2
import efficientnet.tfkeras
from fastapi import Body, FastAPI
from tensorflow.keras.models import load_model

app = FastAPI()
model = load_model('landmark_v1.h5')

def base64_to_image(base64_string):
    bytes_buffer = BytesIO()
    bytes_buffer.write(base64.b64decode(base64_string))
    pil_img = Image.open(bytes_buffer)
    return cv2.cvtColor(np.array(pil_img), cv2.COLOR_RGB2BGR)

def preprocess_image(original_image):
    resized_image = cv2.resize(original_image, (224, 224))
    reshaped_image = resized_image.reshape(-1, 224, 224, 3)
    return reshaped_image / 255

@app.post("/")
async def test(data: str = Body(..., embed=True)):
    start_time = time.time()
    original_image = base64_to_image(data)
    preprocessed_image = preprocess_image(original_image)
    prediction = model.predict(preprocessed_image)
    prediction_time = time.time() - start_time
    predicted_class = int(np.argmax(prediction))
    confidence = np.max(prediction[0])

    return_dict = {"prediction_time": prediction_time, "confidence_level": float(confidence)}

    if confidence > 0.5:
        return_dict.update({"predicted_class": predicted_class})
    else:
        return_dict.update({"predicted_class": -1})

    return return_dict
