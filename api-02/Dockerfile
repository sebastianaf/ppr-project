FROM python:3.9
COPY [".","/usr/uv/app/"]
WORKDIR /usr/uv/app/
EXPOSE 5000
RUN python -m pip install flask
RUN python -m pip install -U flask-cors
RUN python --version
CMD ["python3" "app.py"]