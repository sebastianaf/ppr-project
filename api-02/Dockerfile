FROM python:latest
COPY ["requirements.txt","/usr/uv/ppr/"]
WORKDIR /usr/uv/ppr/
RUN python3 -m pip install -r requirements.txt
COPY [".","/usr/uv/ppr/"]
EXPOSE 5000
CMD ["python3" "app.py"]