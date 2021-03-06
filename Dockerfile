# [START dockerfile]
FROM gcr.io/google_appengine/python

# Install the fortunes binary from the debian repositories.
RUN apt-get update && apt-get install -y cmake

# Change the -p argument to use Python 2.7 if desired.
RUN virtualenv /env -p python2.7

# Set virtualenv environment variables. This is equivalent to running
# source /env/bin/activate.
ENV VIRTUAL_ENV /env
ENV PATH /env/bin:$PATH

ADD requirements.txt /app/
RUN pip install -r requirements.txt
ADD . /app/

CMD gunicorn --timeout 40 -b :$PORT main:app
# [END dockerfile]
