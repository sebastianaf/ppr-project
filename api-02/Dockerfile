FROM python:3.9
COPY ["requirements.txt","/usr/uv/app/"]
WORKDIR /usr/uv/app/
RUN python -m pip install -r requirements.txt
COPY [".","/usr/uv/app/"]
EXPOSE 5000
CMD ["python" "app.py"]