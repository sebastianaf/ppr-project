FROM python:3.9
COPY [".","/usr/uv/app/"]
WORKDIR /usr/uv/app/
RUN python -m pip install flask && \
    python -m pip install -U flask-cors
RUN apt-get update &&\
	apt-get -y install \
		git \
		wget \
		libgl1 && \
	rm -rf /var/lib/apt/lists/* && \
	mkdir /tool && \
	cd /tool && \
	wget https://github.com/MiniZinc/MiniZincIDE/releases/download/2.6.4/MiniZincIDE-2.6.4-bundle-linux-x86_64.tgz && \
	tar -zxvf MiniZincIDE-2.6.4-bundle-linux-x86_64.tgz && \
	mv /tool/MiniZincIDE-2.6.4-bundle-linux /tool/MiniZincIDE && \
	rm -rf MiniZincIDE-2.6.4-bundle-linux-x86_64.tgz
EXPOSE 5000
CMD ["app.py"]
ENTRYPOINT ["python"]