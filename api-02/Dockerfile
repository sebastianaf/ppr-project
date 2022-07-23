FROM python:latest
COPY ["requirements.txt","/usr/uv/app/"]
WORKDIR /usr/uv/app/
RUN python3 -m pip install -r requirements.txt
COPY [".","/usr/uv/app/"]
EXPOSE 5000
CMD ["python3" "app.py"]