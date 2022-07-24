FROM python:3.7
COPY [".","/usr/uv/app/"]
WORKDIR /usr/uv/app/
EXPOSE 5000
RUN apt-get -y install python3-pip
RUN pip3 install flask 
RUN pip3 install -U flask-cors
CMD ["python3" "app.py"]