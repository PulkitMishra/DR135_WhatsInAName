FROM python:3.8

COPY requirements.txt /src/
RUN pip3 install -r /src/requirements.txt
COPY app.py landmark_v1.h5 /src/

EXPOSE 8000
WORKDIR /src/
CMD uvicorn app:app --reload --host 0.0.0.0
